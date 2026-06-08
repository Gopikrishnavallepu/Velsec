import os
os.environ["SUPABASE_JWT_SECRET"] = "test-jwt-secret-for-testing"
os.environ["SYNC_API_KEY"] = "default-sync-key"

import pytest
from fastapi.testclient import TestClient
from app.main import app
from app.api.deps import get_current_user, get_admin_user
from app.core.security import TokenData

# Mock dependencies to avoid requiring live Supabase credentials/tokens during test
async def override_get_current_user():
    return TokenData(sub="00000000-0000-0000-0000-000000000001", email="test@velsec.com", role="authenticated")

async def override_get_admin_user():
    return TokenData(sub="00000000-0000-0000-0000-000000000002", email="admin@velsec.com", role="admin")

app.dependency_overrides[get_current_user] = override_get_current_user
app.dependency_overrides[get_admin_user] = override_get_admin_user

client = TestClient(app)

def test_health_check():
    """Verify that system status health endpoint operates correctly."""
    response = client.get("/health")
    assert response.status_code == 200
    assert response.json() == {"status": "ok", "message": "Velsec API is running"}

def test_list_courses():
    """Verify listing learning modules with progress overrides."""
    response = client.get("/api/v1/learning/courses")
    assert response.status_code == 200
    data = response.json()
    assert isinstance(data, list)
    assert len(data) > 0
    assert data[0]["id"] == "web-pentest"
    assert "progress" in data[0]

def test_enroll_in_course():
    """Verify enrolling a user in a specific lab course."""
    response = client.post("/api/v1/learning/enroll/web-pentest")
    assert response.status_code == 200
    data = response.json()
    assert "status" in data
    assert data["course_id"] == "web-pentest"

def test_update_progress():
    """Verify updating progression records for a course."""
    payload = {"progress": 45}
    response = client.post("/api/v1/learning/progress/web-pentest", json=payload)
    assert response.status_code == 200
    data = response.json()
    assert data["progress"] == 45

def test_update_progress_invalid():
    """Verify invalid progress levels trigger validation constraints."""
    payload = {"progress": 150} # >100 should fail
    response = client.post("/api/v1/learning/progress/web-pentest", json=payload)
    assert response.status_code == 400

def test_list_notes():
    """Verify retrieving pentest notes with search and category filters."""
    response = client.get("/api/v1/notes/")
    assert response.status_code == 200
    data = response.json()
    assert len(data) > 0

    # Test search filter mapping
    search_res = client.get("/api/v1/notes/?search=Nmap")
    assert search_res.status_code == 200
    assert all("nmap" in n["title"].lower() or "nmap" in n["content"].lower() for n in search_res.json())

def test_sync_notes_unauthorized():
    """Verify sync endpoint rejects payloads without correct authorization headers."""
    response = client.post("/api/v1/notes/sync", json=[])
    assert response.status_code == 401

def test_sync_notes_authorized():
    """Verify sync endpoint accepts valid payloads with authorization headers."""
    import os
    expected_key = os.environ.get("SYNC_API_KEY", "default-sync-key")
    payload = [
        {
            "id": "test-dossier",
            "title": "Test Dossier Entry",
            "category": "Cheat Sheets",
            "tags": ["test", "verify"],
            "content": "Verify system components integrity.",
            "last_updated": "2026-06-03"
        }
    ]
    response = client.post(
        "/api/v1/notes/sync",
        json=payload,
        headers={"X-Sync-Key": expected_key}
    )
    assert response.status_code == 200
    assert "status" in response.json()

def test_list_projects():
    """Verify listing system active templates."""
    response = client.get("/api/v1/projects/")
    assert response.status_code == 200
    data = response.json()
    assert len(data) > 0
    assert data[0]["id"] == "p1"

def test_get_profile():
    """Verify retrieving user profile achievements and skill matrix."""
    response = client.get("/api/v1/tracking/profile")
    assert response.status_code == 200
    data = response.json()
    assert data["xp"] == 3450
    assert data["level"] == 3
    assert len(data["skills"]) == 4

def test_update_profile():
    """Verify saving user profile adjustments."""
    payload = {
        "xp": 3800,
        "level": 3,
        "solved_labs": 15,
        "lab_history": [2, 5, 8, 12, 14, 15],
        "skills": [
            {"name": "Python Scripting", "level": 80},
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
    response = client.post("/api/v1/tracking/profile", json=payload)
    assert response.status_code == 200
    data = response.json()
    assert data["xp"] == 3800
    assert len(data["lab_history"]) == 6
