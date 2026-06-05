"""
Auth & Security Functional Tests

Tests cover:
- JWT verification (valid/expired/malformed tokens)
- Protected endpoint access control
- Admin role guard
- Token payload validation
"""

import os
os.environ["SUPABASE_JWT_SECRET"] = "test-jwt-secret-for-testing"
os.environ["SYNC_API_KEY"] = "default-sync-key"

import time
import pytest
import jwt as pyjwt
from fastapi.testclient import TestClient
from app.main import app
from app.api.deps import get_current_user, get_admin_user
from app.core.security import verify_supabase_jwt, TokenData


# ======================================================================
# HELPER: Generate test JWTs
# ======================================================================

JWT_SECRET = "test-jwt-secret-for-testing"

def make_jwt(payload: dict, secret: str = JWT_SECRET) -> str:
    """Create a signed JWT for testing."""
    return pyjwt.encode(payload, secret, algorithm="HS256")


def make_valid_token(
    sub: str = "user-123",
    email: str = "test@velsec.com",
    role: str = "authenticated",
    aud: str = "authenticated",
    exp_offset: int = 3600,
) -> str:
    """Create a valid Supabase-style JWT."""
    return make_jwt({
        "sub": sub,
        "email": email,
        "role": role,
        "aud": aud,
        "exp": int(time.time()) + exp_offset,
        "iat": int(time.time()),
    })


# ======================================================================
# TEST GROUP 1: JWT Verification (verify_supabase_jwt)
# ======================================================================

class TestJWTVerification:
    """Tests for the core JWT verification function in security.py."""

    def test_valid_token_returns_token_data(self):
        """Valid JWT with correct claims should return TokenData."""
        token = make_valid_token()
        result = verify_supabase_jwt(token)

        assert isinstance(result, TokenData)
        assert result.sub == "user-123"
        assert result.email == "test@velsec.com"
        assert result.role == "authenticated"

    def test_valid_token_with_admin_role(self):
        """JWT with admin role should preserve role in TokenData."""
        token = make_valid_token(role="admin")
        result = verify_supabase_jwt(token)
        assert result.role == "admin"

    def test_expired_token_raises_401(self):
        """Expired JWT should raise HTTPException with 401."""
        token = make_valid_token(exp_offset=-3600)  # Expired 1 hour ago
        from fastapi import HTTPException
        with pytest.raises(HTTPException) as exc_info:
            verify_supabase_jwt(token)
        assert exc_info.value.status_code == 401
        assert "expired" in exc_info.value.detail.lower()

    def test_wrong_secret_raises_401(self):
        """JWT signed with wrong secret should raise 401."""
        token = make_jwt({
            "sub": "user-123",
            "email": "test@velsec.com",
            "role": "authenticated",
            "aud": "authenticated",
            "exp": int(time.time()) + 3600,
        }, secret="wrong-secret")
        from fastapi import HTTPException
        with pytest.raises(HTTPException) as exc_info:
            verify_supabase_jwt(token)
        assert exc_info.value.status_code == 401

    def test_missing_sub_raises_401(self):
        """JWT without sub claim should raise 401."""
        token = make_jwt({
            "email": "test@velsec.com",
            "role": "authenticated",
            "aud": "authenticated",
            "exp": int(time.time()) + 3600,
        })
        from fastapi import HTTPException
        with pytest.raises(HTTPException) as exc_info:
            verify_supabase_jwt(token)
        assert exc_info.value.status_code == 401

    def test_missing_email_raises_401(self):
        """JWT without email claim should raise 401."""
        token = make_jwt({
            "sub": "user-123",
            "role": "authenticated",
            "aud": "authenticated",
            "exp": int(time.time()) + 3600,
        })
        from fastapi import HTTPException
        with pytest.raises(HTTPException) as exc_info:
            verify_supabase_jwt(token)
        assert exc_info.value.status_code == 401

    def test_wrong_audience_raises_401(self):
        """JWT with wrong audience should raise 401."""
        token = make_jwt({
            "sub": "user-123",
            "email": "test@velsec.com",
            "role": "authenticated",
            "aud": "anon",  # Wrong audience
            "exp": int(time.time()) + 3600,
        })
        from fastapi import HTTPException
        with pytest.raises(HTTPException) as exc_info:
            verify_supabase_jwt(token)
        assert exc_info.value.status_code == 401

    def test_malformed_token_raises_401(self):
        """Completely invalid token string should raise 401."""
        from fastapi import HTTPException
        with pytest.raises(HTTPException) as exc_info:
            verify_supabase_jwt("not.a.valid.jwt")
        assert exc_info.value.status_code == 401

    def test_empty_token_raises_401(self):
        """Empty token should raise 401."""
        from fastapi import HTTPException
        with pytest.raises(HTTPException) as exc_info:
            verify_supabase_jwt("")
        assert exc_info.value.status_code == 401

    def test_default_role_is_authenticated(self):
        """Token without role claim should default to 'authenticated'."""
        token = make_jwt({
            "sub": "user-123",
            "email": "test@velsec.com",
            "aud": "authenticated",
            "exp": int(time.time()) + 3600,
        })
        result = verify_supabase_jwt(token)
        assert result.role == "authenticated"


# ======================================================================
# TEST GROUP 2: Protected Endpoint Access
# ======================================================================

# Create a test client that does NOT override auth dependencies
# so we can test real JWT verification through the API
raw_app_client = TestClient(app)

class TestProtectedEndpoints:
    """Tests for endpoints behind get_current_user dependency."""

    @pytest.fixture(autouse=True)
    def _clear_and_restore_overrides(self):
        """Remove mocked auth overrides before test, restore after."""
        # Save current overrides
        saved = dict(app.dependency_overrides)
        # Remove auth overrides for real JWT testing
        app.dependency_overrides.pop(get_current_user, None)
        app.dependency_overrides.pop(get_admin_user, None)
        yield
        # Restore overrides so other test files are not affected
        app.dependency_overrides.update(saved)

    def test_no_auth_header_returns_401(self):
        """Request without Authorization header should get 401."""
        client = TestClient(app)

        response = client.get("/api/v1/learning/courses")
        assert response.status_code == 401  # HTTPBearer returns 401 when no credentials

    def test_invalid_bearer_token_returns_401(self):
        """Request with invalid Bearer token should get 401."""
        client = TestClient(app)

        response = client.get(
            "/api/v1/learning/courses",
            headers={"Authorization": "Bearer invalid-token-here"}
        )
        assert response.status_code == 401

    def test_valid_bearer_token_returns_200(self):
        """Request with valid Bearer token should succeed."""
        client = TestClient(app)

        token = make_valid_token()
        response = client.get(
            "/api/v1/learning/courses",
            headers={"Authorization": f"Bearer {token}"}
        )
        assert response.status_code == 200

    def test_expired_bearer_token_returns_401(self):
        """Request with expired Bearer token should get 401."""
        client = TestClient(app)

        token = make_valid_token(exp_offset=-3600)
        response = client.get(
            "/api/v1/learning/courses",
            headers={"Authorization": f"Bearer {token}"}
        )
        assert response.status_code == 401

    def test_profile_endpoint_with_valid_token(self):
        """Profile endpoint should return data with valid token."""
        client = TestClient(app)

        token = make_valid_token()
        response = client.get(
            "/api/v1/tracking/profile",
            headers={"Authorization": f"Bearer {token}"}
        )
        assert response.status_code == 200
        data = response.json()
        assert "xp" in data
        assert "level" in data

    def test_notes_endpoint_with_valid_token(self):
        """Notes endpoint should return data with valid token."""
        client = TestClient(app)

        token = make_valid_token()
        response = client.get(
            "/api/v1/notes/",
            headers={"Authorization": f"Bearer {token}"}
        )
        assert response.status_code == 200


# ======================================================================
# TEST GROUP 3: Health Check (Public Endpoint)
# ======================================================================

class TestPublicEndpoints:
    """Tests for endpoints that don't require auth."""

    def test_health_check_no_auth_required(self):
        """Health endpoint should be accessible without auth."""
        client = TestClient(app)
        response = client.get("/health")
        assert response.status_code == 200
        assert response.json()["status"] == "ok"


# ======================================================================
# TEST GROUP 4: Token Data Model
# ======================================================================

class TestTokenDataModel:
    """Tests for the TokenData pydantic model."""

    def test_token_data_creation(self):
        """TokenData should accept valid fields."""
        td = TokenData(sub="user-1", email="a@b.com", role="authenticated")
        assert td.sub == "user-1"
        assert td.email == "a@b.com"
        assert td.role == "authenticated"

    def test_token_data_default_role(self):
        """TokenData should default role to 'authenticated'."""
        td = TokenData(sub="user-1", email="a@b.com")
        assert td.role == "authenticated"
