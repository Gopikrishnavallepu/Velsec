from fastapi import FastAPI
from fastapi.middleware.cors import CORSMiddleware
from app.api.routers import learning, tracking, notes, projects

app = FastAPI(
    title="Velsec API",
    description="Backend API for Velsec Cybersecurity Learning and Solutions Ecosystem",
    version="1.0.0",
)

# CORS configuration
origins = [
    "http://localhost:3000",
    "http://velsec.com",
    "https://velsec.com",
    "http://learn.velsec.com",
    "https://learn.velsec.com",
]

app.add_middleware(
    CORSMiddleware,
    allow_origins=origins,
    allow_credentials=True,
    allow_methods=["*"],
    allow_headers=["*"],
)

# Include routers
app.include_router(learning.router, prefix="/api/v1/learning", tags=["Learning"])
app.include_router(tracking.router, prefix="/api/v1/tracking", tags=["Tracking"])
app.include_router(notes.router, prefix="/api/v1/notes", tags=["Notes"])
app.include_router(projects.router, prefix="/api/v1/projects", tags=["Projects"])

@app.get("/health", tags=["System"])
async def health_check():
    return {"status": "ok", "message": "Velsec API is running"}
