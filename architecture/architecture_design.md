# Velsec Architecture Design
## Ultimate Cybersecurity Learning and Solutions Ecosystem

This document outlines the high-level architecture, security controls, and infrastructure design for Velsec, optimized for free-tier cloud environments using free and open-source software (FOSS).

## 1. System Architecture

The core architecture follows a scalable, event-driven microservices pattern.

```mermaid
graph TD
    User([User / Client])
    CF[Cloudflare WAF/CDN]
    Ingress[Nginx Ingress Controller]
    API_Gateway[API Gateway / BFF]
    
    subgraph "Velsec Kubernetes Cluster"
        Ingress --> API_Gateway
        API_Gateway --> Auth[Auth Service <br> Keycloak]
        API_Gateway --> Learn[Learning Service]
        API_Gateway --> Labs[Lab Environment Service]
        API_Gateway --> Forum[Community Forum Service]
        
        Auth --> DB_Auth[(Auth DB)]
        Learn --> DB_Learn[(Learning DB)]
        Labs --> MQ[RabbitMQ]
        Forum --> DB_Forum[(Forum DB)]
        
        MQ --> LabWorker[Lab Provisioner Worker]
    end
    
    User -->|HTTPS| CF
    CF -->|HTTPS| Ingress
```

## 2. Database Design

Using a mix of PostgreSQL for relational data and Redis for caching.

```mermaid
erDiagram
    USER {
        uuid id PK
        string username
        string email
        string password_hash
        string role
        timestamp created_at
    }
    COURSE {
        uuid id PK
        string title
        string description
        string difficulty
    }
    ENROLLMENT {
        uuid id PK
        uuid user_id FK
        uuid course_id FK
        string status
        int progress
    }
    LAB_SESSION {
        uuid id PK
        uuid user_id FK
        uuid lab_id
        string container_id
        string status
    }
    
    USER ||--o{ ENROLLMENT : "has"
    COURSE ||--o{ ENROLLMENT : "includes"
    USER ||--o{ LAB_SESSION : "starts"
```

## 3. Microservices Design

Each service is decoupled, managing its own domain and database to ensure scalability and fault tolerance.

```mermaid
graph LR
    API[API Gateway] --> S1[Auth Service]
    API --> S2[Course Management Service]
    API --> S3[Lab Orchestration Service]
    API --> S4[Progress Tracking Service]
    API --> S5[Notification Service]
    
    S3 -->|Events| MQ((RabbitMQ))
    S4 -->|Events| MQ
    MQ --> S5
```

## 4. API Structure

The API is RESTful with potential GraphQL endpoints for complex querying.

```mermaid
sequenceDiagram
    participant Client
    participant Gateway
    participant AuthService
    participant ResourceService

    Client->>Gateway: POST /api/v1/auth/login
    Gateway->>AuthService: Forward Login Request
    AuthService-->>Gateway: JWT Access & Refresh Tokens
    Gateway-->>Client: Returns JWT
    
    Client->>Gateway: GET /api/v1/courses (with JWT)
    Gateway->>Gateway: Validate JWT
    Gateway->>ResourceService: Fetch Courses
    ResourceService-->>Gateway: Course Data (JSON)
    Gateway-->>Client: Returns 200 OK + Data
```

- `api.velsec.org/v1/auth/*` - Identity & Access Management
- `api.velsec.org/v1/learn/*` - Curriculum, courses, content delivery
- `api.velsec.org/v1/labs/*` - Ephemeral cybersecurity lab management
- `api.velsec.org/v1/users/*` - Profiles, settings, progression

## 5. Security Controls

- **Edge Security:** Cloudflare WAF (Free Tier), DDoS Protection, strict SSL/TLS (Strict Mode).
- **Application Security:**
  - Input Validation & Sanitization (OWASP recommendations).
  - Rate Limiting at the API Gateway.
  - JWT for stateless authentication; short-lived access tokens, HTTP-only secure cookies for refresh tokens.
  - CORS policies explicitly defined per environment.
- **Infrastructure Security:**
  - Container images scanned via Trivy during CI.
  - Least privilege IAM roles in Kubernetes (RBAC).
  - Network Policies in Kubernetes to restrict namespace communication.
  - Secrets managed via SOPS / Kubernetes Sealed Secrets (no plain text in git).

## 6. User Roles

| Role Name | Access Level | Description |
| :--- | :--- | :--- |
| **Guest** | Read-only | Can view public courses, forums, and marketing pages. |
| **Student** | Standard User | Can enroll in courses, spawn free-tier labs, post in forums. |
| **Pro User** | Premium User | Access to advanced labs, certification paths, priority support. |
| **Instructor** | Content Creator | Can create/edit courses, view student progress, moderate discussions. |
| **Admin** | Superuser | Full system access, user management, infrastructure logs. |

## 7. Authentication Design

Delegated authentication leveraging an open-source Identity Provider like Keycloak.

```mermaid
sequenceDiagram
    participant User
    participant Frontend
    participant Keycloak
    participant Backend
    
    User->>Frontend: Clicks "Login"
    Frontend->>Keycloak: Redirects to OAuth2/OIDC Auth URL
    User->>Keycloak: Enters Credentials + MFA
    Keycloak-->>Frontend: Redirects back with Auth Code
    Frontend->>Keycloak: Exchanges Code for JWT Tokens
    Keycloak-->>Frontend: Returns Access & Refresh Tokens
    Frontend->>Backend: API Request with Bearer Token
    Backend->>Keycloak: (Async) Validate Token Signature/Keys
    Backend-->>Frontend: Secured Data Response
```

## 8. Multi-subdomain Architecture

Segregation of duties across subdomains mapped via Cloudflare and Nginx Ingress.

```mermaid
graph TD
    Root((velsec.org)) --> WWW(www.velsec.org <br> Landing Page)
    Root --> App(app.velsec.org <br> Main Web App)
    Root --> API(api.velsec.org <br> API Gateway)
    Root --> Labs(labs.velsec.org <br> Live Lab Instances)
    Root --> Auth(auth.velsec.org <br> SSO / Keycloak)
```

## 9. DevSecOps Pipeline

Automated zero-trust CI/CD using GitHub Actions.

```mermaid
flowchart LR
    Commit[Git Push] --> Lint[Linting & SAST <br> Semgrep]
    Lint --> Build[Build Docker Image]
    Build --> Scan[Container Scan <br> Trivy]
    Scan --> Push[Push to GitHub Container Registry]
    Push --> Deploy[Deploy to K8s <br> ArgoCD/GitOps]
    
    style Lint stroke:#f66,stroke-width:2px
    style Scan stroke:#f66,stroke-width:2px
```

## 10. Kubernetes Deployment Architecture

Lightweight Kubernetes (K3s) deployment suitable for free-tier / minimal infrastructure (e.g., Oracle Cloud Free Tier ARM instances).

```mermaid
graph TD
    subgraph "K3s Node (Oracle Cloud / VPS)"
        Ingress[Ingress Nginx]
        
        subgraph "Namespace: velsec-prod"
            WebPod[Frontend Pods]
            APIPod[API Pods]
            AuthPod[Keycloak Pods]
        end
        
        subgraph "Namespace: velsec-labs"
            Lab1[Ephemeral Kali Pod]
            Lab2[Target Vuln Pod]
        end
        
        Ingress --> WebPod
        Ingress --> APIPod
        Ingress --> AuthPod
        Ingress --> Lab1
    end
```

## 11. Cloudflare Integration

Leveraging free Cloudflare features to protect and accelerate the ecosystem.

```mermaid
graph TD
    User((User)) -->|DNS Query| CF_DNS[Cloudflare DNS]
    User -->|HTTPS Request| CF_Edge[Cloudflare Edge Network]
    
    CF_Edge --> CF_WAF[Cloudflare WAF <br> Managed Rulesets]
    CF_Edge --> CF_Cache[CDN Caching]
    
    CF_WAF --> Origin[Origin Server / K8s Ingress]
    
    style CF_Edge fill:#f9a,stroke:#333
    style CF_WAF fill:#f9a,stroke:#333
```

## 12. GitHub Repository Structure

A monorepo structure initially, optimizing for developer velocity, later split if necessary.

```text
velsec-org/
├── .github/
│   ├── workflows/             # CI/CD Pipelines (Build, Test, Scan, Deploy)
│   └── CODEOWNERS
├── architecture/              # Architecture diagrams & documentation
├── apps/                      
│   ├── web-client/            # Next.js Frontend Application
│   ├── api-gateway/           # Express/FastAPI Edge Gateway
│   └── admin-dashboard/       # Internal tool for staff
├── packages/                  # Shared libraries
│   ├── ui-components/         # Reusable React components
│   ├── common-types/          # Shared TypeScript interfaces
│   └── security-utils/        # Shared encryption/auth utilities
├── services/                  # Microservices
│   ├── auth-service/          # Keycloak custom themes / extensions
│   ├── learning-service/      # Core course management backend
│   └── lab-service/           # Kubernetes operator / provisioner
├── infrastructure/            # Infrastructure as Code (IaC)
│   ├── kubernetes/            # Kubernetes manifests & Helm charts
│   ├── terraform/             # Cloud provisioning FOSS scripts
│   └── cloudflare/            # Cloudflare rules config
├── scripts/                   # Local dev setup and utility scripts
├── .gitignore
├── README.md                  # Project overview and getting started
└── docker-compose.yml         # Local development environment
```
