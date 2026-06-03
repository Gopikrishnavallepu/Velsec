from fastapi import APIRouter, Depends
from typing import List
from pydantic import BaseModel
from app.api.deps import get_admin_user, TokenData

router = APIRouter()

class ThreatActorSchema(BaseModel):
    id: str
    name: str
    origin: str
    active: bool

@router.get("/actors", response_model=List[ThreatActorSchema])
async def list_threat_actors(current_user: TokenData = Depends(get_admin_user)):
    """List tracked threat actors. Requires Admin privileges."""
    return [
        ThreatActorSchema(id="ta1", name="APT29", origin="Unknown", active=True)
    ]
