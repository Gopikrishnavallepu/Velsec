# Velsec - Ultimate Cybersecurity Learning and Solutions Ecosystem

Welcome to the **Velsec** repository. This is the monorepo containing the microservices, frontend applications, and infrastructure configurations for the Velsec platform.

## Architecture

This project is designed as an event-driven microservices ecosystem, deployed on Kubernetes, utilizing free-tier open-source solutions where possible (e.g., Keycloak, PostgreSQL, Redis, RabbitMQ) to maintain scalability and low costs.

For detailed architecture diagrams (System, Microservices, Security, DB, CI/CD, etc.), please view:
[Architecture Documentation](./architecture/architecture_design.md)

## Repository Structure

```
velsec-org/
├── .github/workflows/       # CI/CD Actions
├── architecture/            # Design documentation & Mermaid diagrams
├── apps/                    # Next.js Frontend and Edge API gateways
├── packages/                # Shared internal libraries (Types, UI, Utils)
├── services/                # Core domain microservices
├── infrastructure/          # IaC (Kubernetes, Terraform, Cloudflare config)
└── scripts/                 # Utility scripts for local dev setup
```

## Getting Started

*(Application logic is currently pending. Architecture planning is complete.)*

## Security 

This project implements strict security controls:
- **Authentication**: Keycloak (OIDC/OAuth2) with JWTs.
- **Perimeter**: Cloudflare WAF, strict SSL/TLS, and DDoS mitigation.
- **DevSecOps**: Semgrep for SAST, Trivy for container scanning.
- **Network**: Kubernetes NetworkPolicies for zero-trust intra-cluster comms.
