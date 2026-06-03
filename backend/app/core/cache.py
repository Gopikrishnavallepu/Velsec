import redis.asyncio as redis
from app.core.config import settings
import logging

logger = logging.getLogger(__name__)

class CacheService:
    def __init__(self):
        self.redis_client = None

    async def connect(self):
        try:
            self.redis_client = await redis.from_url(settings.REDIS_URL, decode_responses=True)
            # test connection
            await self.redis_client.ping()
            logger.info("Connected to Redis successfully.")
        except Exception as e:
            logger.error(f"Redis connection error: {e}")

    async def close(self):
        if self.redis_client:
            await self.redis_client.aclose()

cache_service = CacheService()
