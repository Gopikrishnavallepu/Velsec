from fastapi import APIRouter
from typing import List
from pydantic import BaseModel

router = APIRouter()

class ProjectSchema(BaseModel):
    id: str
    name: str
    github_url: str

@router.get("/", response_model=List[ProjectSchema])
async def list_open_source_projects():
    """List public Velsec open source projects."""
    return [
        ProjectSchema(id="p1", name="Velsec-Scanner", github_url="https://github.com/velsec-org/scanner")
    ]
