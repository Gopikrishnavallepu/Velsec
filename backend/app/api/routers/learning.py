from fastapi import APIRouter, Depends, HTTPException, status
from typing import List, Optional
from pydantic import BaseModel
import os
import logging
from app.api.deps import get_current_user, TokenData
from app.core.config import settings

logger = logging.getLogger(__name__)

router = APIRouter()

class CourseSchema(BaseModel):
    id: str
    title: str
    description: str
    category: str
    level: str
    hours: int
    modules: List[str]
    progress: int = 0

class ProgressUpdateSchema(BaseModel):
    progress: int

# Local mock database fallbacks
MOCK_COURSES = [
    {
        "id": "web-pentest",
        "title": "Web Application Penetration Testing",
        "category": "web",
        "level": "Intermediate",
        "hours": 24,
        "description": "Learn modern exploitation techniques, from advanced SQL injections to OAuth vulnerabilities, with fully interactive virtual labs.",
        "modules": ["Reconnaissance & Mapping", "Injection Flaws & Exploit Design", "Bypassing WAF & OAuth Vulnerabilities", "Final Sandbox Pentest Challenge"],
    },
    {
        "id": "cloud-sec",
        "title": "Cloud Security & IAM Hardening",
        "category": "cloud",
        "level": "Advanced",
        "hours": 18,
        "description": "Secure AWS, GCP, and Azure workloads. Learn to identify and exploit IAM misconfigurations and build bulletproof Cloud environments.",
        "modules": ["IAM Privilege Escalation", "Securing Kubernetes Clusters", "Terraform Sentinel Policy Design", "Cloud Threat Detection & GuardDuty Setup"],
    },
    {
        "id": "rev-eng",
        "title": "Reverse Engineering & Malware Analysis",
        "category": "malware",
        "level": "Expert",
        "hours": 32,
        "description": "Unpack malware samples, analyze assembly bytecode, and learn to write memory bypasses in Windows and Linux systems.",
        "modules": ["Assembly Crash Course", "Static Analysis with Ghidra & IDA", "Dynamic Analysis & Debugging", "Bypassing Anti-Analysis & Sandbox Checks"],
    },
    {
        "id": "threat-hunt",
        "title": "Defensive Security & Threat Hunting",
        "category": "defense",
        "level": "Beginner",
        "hours": 15,
        "description": "Monitor enterprise logs, detect adversarial persistence techniques using ELK stack, and write defensive Yara rules.",
        "modules": ["Log Analysis & SIEM Deployment", "Detecting Adversary Persistence", "Yara Rules & Signature Writing", "Incident Response Runbook Simulation"],
    }
]

MOCK_ENROLLMENTS = {}  # key: (user_id, course_id) -> progress (int)

# Initialize Supabase client if possible
supabase = None
try:
    if (settings.SUPABASE_URL and settings.SUPABASE_KEY and
        "your-project" not in settings.SUPABASE_URL and
        "placeholder" not in settings.SUPABASE_URL):
        from supabase import create_client
        supabase = create_client(settings.SUPABASE_URL, settings.SUPABASE_KEY)
except Exception as e:
    logger.warning(f"Could not connect to Supabase: {e}. Falling back to in-memory local state.")

@router.get("/courses", response_model=List[CourseSchema])
async def list_courses(current_user: TokenData = Depends(get_current_user)):
    """List all available courses with authenticated user's current progress."""
    user_id = current_user.sub
    
    # 1. Load courses from Supabase or Mock
    courses_list = []
    if supabase:
        try:
            res = supabase.table("courses").select("*").execute()
            courses_list = res.data
        except Exception as e:
            logger.error(f"Supabase courses fetch error: {e}. Using fallback mock courses.")
            courses_list = MOCK_COURSES
    else:
        courses_list = MOCK_COURSES

    # 2. Load enrollments for current user to map progress
    user_progress = {}
    if supabase:
        try:
            res = supabase.table("enrollments").select("course_id, progress").eq("user_id", user_id).execute()
            for item in res.data:
                user_progress[item["course_id"]] = item["progress"]
        except Exception as e:
            logger.error(f"Supabase enrollments fetch error: {e}.")
    else:
        # Load from local mock enrollments
        for (u_id, c_id), prog in MOCK_ENROLLMENTS.items():
            if u_id == user_id:
                user_progress[c_id] = prog

    # 3. Assemble and return course models
    results = []
    for c in courses_list:
        results.append(CourseSchema(
            id=c.get("id"),
            title=c.get("title"),
            description=c.get("description"),
            category=c.get("category"),
            level=c.get("level"),
            hours=c.get("hours"),
            modules=c.get("modules", []),
            progress=user_progress.get(c.get("id"), 0)
        ))
    return results

@router.post("/enroll/{course_id}")
async def enroll_in_course(course_id: str, current_user: TokenData = Depends(get_current_user)):
    """Enroll an authenticated user in a course."""
    user_id = current_user.sub

    if supabase:
        try:
            # Upsert enrollment with progress=0
            res = supabase.table("enrollments").upsert({
                "user_id": user_id,
                "course_id": course_id,
                "progress": 0
            }, on_conflict="user_id,course_id").execute()
            return {"status": "enrolled", "course_id": course_id, "user_id": user_id}
        except Exception as e:
            logger.error(f"Supabase enrollment failed: {e}")
            raise HTTPException(
                status_code=status.HTTP_500_INTERNAL_SERVER_ERROR,
                detail=f"Database enrollment failed: {str(e)}"
            )
    
    # Fallback to local in-memory dict
    MOCK_ENROLLMENTS[(user_id, course_id)] = 0
    return {
        "status": "fallback_enrolled",
        "message": "Saved to local memory (Supabase not configured).",
        "course_id": course_id,
        "user_id": user_id
    }

@router.post("/progress/{course_id}")
async def update_progress(
    course_id: str, 
    payload: ProgressUpdateSchema, 
    current_user: TokenData = Depends(get_current_user)
):
    """Update progress percentage for a course enrollment."""
    user_id = current_user.sub
    new_progress = payload.progress

    if new_progress < 0 or new_progress > 100:
        raise HTTPException(status_code=400, detail="Progress percentage must be between 0 and 100.")

    if supabase:
        try:
            res = supabase.table("enrollments").update({
                "progress": new_progress
            }).eq("user_id", user_id).eq("course_id", course_id).execute()
            
            if not res.data:
                # If no record was updated, user might not be enrolled yet. Try upserting.
                supabase.table("enrollments").upsert({
                    "user_id": user_id,
                    "course_id": course_id,
                    "progress": new_progress
                }, on_conflict="user_id,course_id").execute()
                
            return {"status": "updated", "course_id": course_id, "progress": new_progress}
        except Exception as e:
            logger.error(f"Supabase progress update failed: {e}")
            raise HTTPException(
                status_code=status.HTTP_500_INTERNAL_SERVER_ERROR,
                detail=f"Database progress update failed: {str(e)}"
            )

    # Fallback to local memory
    MOCK_ENROLLMENTS[(user_id, course_id)] = new_progress
    return {
        "status": "fallback_updated",
        "course_id": course_id,
        "progress": new_progress
    }
