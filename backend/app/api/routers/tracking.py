from fastapi import APIRouter, Depends, HTTPException, status
from typing import List, Optional
from pydantic import BaseModel
from app.api.deps import get_admin_user, get_current_user, TokenData
from app.core.config import settings
import logging
import os

logger = logging.getLogger(__name__)

router = APIRouter()

class ThreatActorSchema(BaseModel):
    id: str
    name: str
    origin: str
    active: bool

class SkillSchema(BaseModel):
    name: str
    level: int

class CertSchema(BaseModel):
    id: str
    name: str
    acquired: bool

class BadgeSchema(BaseModel):
    id: str
    name: str
    icon: str
    description: str
    unlocked: bool
    unlockedAt: Optional[str] = None

class ProfileSchema(BaseModel):
    xp: int
    level: int
    solved_labs: int
    lab_history: List[int]
    skills: List[SkillSchema]
    certs: List[CertSchema]
    badges: List[BadgeSchema]

# In-memory profiles database for local fallback
MOCK_PROFILES = {}

# Initialize Supabase client if possible
supabase = None
try:
    if (settings.SUPABASE_URL and settings.SUPABASE_KEY and
        "your-project" not in settings.SUPABASE_URL and
        "placeholder" not in settings.SUPABASE_URL):
        from supabase import create_client
        supabase = create_client(settings.SUPABASE_URL, settings.SUPABASE_KEY)
except Exception as e:
    logger.warning(f"Could not connect to Supabase: {e}. Using in-memory fallback profiles.")

# Default profile template
def get_default_profile() -> dict:
    return {
        "xp": 3450,
        "level": 3,
        "solved_labs": 14,
        "lab_history": [2, 5, 8, 12, 14],
        "skills": [
            {"name": "Python Scripting", "level": 75},
            {"name": "Docker / Kubernetes Sec", "level": 50},
            {"name": "Linux System Internals", "level": 60},
            {"name": "Threat Hunting (ELK)", "level": 40}
        ],
        "certs": [
            {"id": "secplus", "name": "Security+", "acquired": True},
            {"id": "oscp", "name": "OSCP", "acquired": False},
            {"id": "cissp", "name": "CISSP", "acquired": False},
            {"id": "ceh", "name": "CEH", "acquired": True}
        ],
        "badges": [
            {"id": "first_blood", "name": "First Blood", "icon": "🩸", "description": "Solve your first practical lab sandbox.", "unlocked": True, "unlockedAt": "2026-05-10"},
            {"id": "buffer_buster", "name": "Buffer Buster", "icon": "💥", "description": "Complete stack overflow binary execution.", "unlocked": True, "unlockedAt": "2026-05-18"},
            {"id": "cloud_tamer", "name": "Cloud Tamer", "icon": "☁️", "description": "Resolve container namespace escapes.", "unlocked": False},
            {"id": "secops_master", "name": "SecOps Master", "icon": "👑", "description": "Configure secure automated staging pipelines.", "unlocked": False}
        ]
    }

@router.get("/actors", response_model=List[ThreatActorSchema])
async def list_threat_actors(current_user: TokenData = Depends(get_admin_user)):
    """List tracked threat actors. Requires Admin privileges."""
    return [
        ThreatActorSchema(id="ta1", name="APT29", origin="Unknown", active=True)
    ]

@router.get("/profile", response_model=ProfileSchema)
async def get_profile(current_user: TokenData = Depends(get_current_user)):
    """Fetch user profile achievements, levels, and skill matrix."""
    user_id = current_user.sub

    if supabase:
        try:
            res = supabase.table("profiles").select("*").eq("user_id", user_id).execute()
            if res.data:
                profile = res.data[0]
                return ProfileSchema(
                    xp=profile.get("xp", 0),
                    level=profile.get("level", 1),
                    solved_labs=profile.get("solved_labs", 0),
                    lab_history=profile.get("lab_history", []),
                    skills=[SkillSchema(**s) for s in profile.get("skills", [])],
                    certs=[CertSchema(**c) for c in profile.get("certs", [])],
                    badges=[BadgeSchema(**b) for b in profile.get("badges", [])]
                )
        except Exception as e:
            logger.error(f"Supabase profiles fetch error: {e}. Falling back to memory.")

    # Fallback to local dict
    if user_id not in MOCK_PROFILES:
        MOCK_PROFILES[user_id] = get_default_profile()
    
    p = MOCK_PROFILES[user_id]
    return ProfileSchema(**p)

@router.post("/profile", response_model=ProfileSchema)
async def update_profile(
    profile_data: ProfileSchema, 
    current_user: TokenData = Depends(get_current_user)
):
    """Save user profile achievements, levels, and skill matrix."""
    user_id = current_user.sub
    serialized_data = profile_data.model_dump()

    if supabase:
        try:
            # Upsert user profile
            record = {
                "user_id": user_id,
                "xp": profile_data.xp,
                "level": profile_data.level,
                "solved_labs": profile_data.solved_labs,
                "lab_history": profile_data.lab_history,
                "skills": serialized_data["skills"],
                "certs": serialized_data["certs"],
                "badges": serialized_data["badges"]
            }
            supabase.table("profiles").upsert(record, on_conflict="user_id").execute()
            return profile_data
        except Exception as e:
            logger.error(f"Supabase profiles save error: {e}. Falling back to memory.")

    # In-memory fallback
    MOCK_PROFILES[user_id] = serialized_data
    return profile_data
