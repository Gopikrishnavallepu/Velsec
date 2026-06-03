import jwt
from fastapi import HTTPException, status
from app.core.config import settings
from pydantic import BaseModel

class TokenData(BaseModel):
    sub: str
    email: str
    role: str = "authenticated"

def verify_supabase_jwt(token: str) -> TokenData:
    try:
        # Verify JWT signed by Supabase (HS256)
        payload = jwt.decode(
            token,
            settings.SUPABASE_JWT_SECRET,
            algorithms=["HS256"],
            audience="authenticated"
        )
        
        user_id = payload.get("sub")
        email = payload.get("email")
        role = payload.get("role", "authenticated")
        
        if user_id is None or email is None:
            raise HTTPException(status_code=401, detail="Invalid token payload")
            
        return TokenData(sub=user_id, email=email, role=role)
        
    except jwt.ExpiredSignatureError:
        raise HTTPException(status_code=401, detail="Token has expired")
    except jwt.JWTError:
        raise HTTPException(status_code=401, detail="Could not validate credentials")
