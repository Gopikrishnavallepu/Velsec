from contextlib import asynccontextmanager
from fastapi import FastAPI
from fastapi.middleware.cors import CORSMiddleware
from app.api.routers import learning, tracking, notes, projects
from app.core.cache import cache_service

@asynccontextmanager
async def lifespan(app: FastAPI):
    # Connect cache service on startup
    await cache_service.connect()
    yield
    # Close cache service on shutdown
    await cache_service.close()

app = FastAPI(
    title="Velsec API",
    description="Backend API for Velsec Cybersecurity Learning and Solutions Ecosystem",
    version="1.0.0",
    lifespan=lifespan,
)

# CORS configuration
origins = [
    "http://localhost:3000",
    "http://velsec.com",
    "https://velsec.com",
    "http://learn.velsec.com",
    "https://learn.velsec.com",
    "http://notes.velsec.com",
    "https://notes.velsec.com",
    "http://tracker.velsec.com",
    "https://tracker.velsec.com",
    "http://personal.velsec.com",
    "https://personal.velsec.com",
    # Vercel deployments
    "https://velsec-org.vercel.app",
    "https://velsec-org-velse-s-projects.vercel.app",
]

# Also allow any *.vercel.app preview deployment origin
import re
origin_pattern = re.compile(r"https://velsec.*\.vercel\.app$")

app.add_middleware(
    CORSMiddleware,
    allow_origins=origins,
    allow_origin_regex=r"https://velsec.*\.vercel\.app",
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
