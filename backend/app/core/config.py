from pydantic_settings import BaseSettings

class Settings(BaseSettings):
    PROJECT_NAME: str = "Velsec API"
    SUPABASE_URL: str = "https://your-project-id.supabase.co"
    SUPABASE_KEY: str = "your-anon-key"
    SUPABASE_JWT_SECRET: str
    SYNC_API_KEY: str
    REDIS_URL: str = "redis://localhost:6379"
    DATABASE_URL: str = "postgresql+asyncpg://postgres:postgres@localhost:5432/velsec"

    class Config:
        env_file = ".env"

settings = Settings()
