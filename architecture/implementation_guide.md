# Velsec — Step-by-Step Implementation Guide

> **Cost Target: $0/month** (domain name excluded)
> This guide covers the complete end-to-end build of the Velsec Cybersecurity Ecosystem using only free and open-source tools.

---

## Phase 1 — Foundation (✅ COMPLETED)

| Step | Task | Tool / Input | Status |
|------|------|-------------|--------|
| 1.1 | System Architecture Design | Mermaid.js diagrams | ✅ Done |
| 1.2 | Database Schema Design | PostgreSQL + Supabase | ✅ Done |
| 1.3 | Microservices / API Design | FastAPI modular monolith | ✅ Done |
| 1.4 | Security Controls Design | RBAC, JWT, WAF | ✅ Done |
| 1.5 | Repository Scaffold | GitHub monorepo | ✅ Done |

---

## Phase 2 — Frontend (✅ COMPLETED)

| Step | Task | Tool / Input | Status |
|------|------|-------------|--------|
| 2.1 | Next.js 15 Project Init | `npx create-next-app` | ✅ Done |
| 2.2 | Tailwind CSS v4 Cyberpunk Theme | `globals.css` @theme block | ✅ Done |
| 2.3 | React Three Fiber 3D Scene | CyberGlobe + DataMesh | ✅ Done |
| 2.4 | Subdomain Routing (7 domains) | Next.js Proxy middleware | ✅ Done |
| 2.5 | Landing Pages for all subdomains | App Router pages | ✅ Done |

---

## Phase 3 — Backend (✅ COMPLETED)

| Step | Task | Tool / Input | Status |
|------|------|-------------|--------|
| 3.1 | FastAPI Project Scaffold | `requirements.txt` | ✅ Done |
| 3.2 | Supabase JWT Auth + RBAC | `security.py` + `deps.py` | ✅ Done |
| 3.3 | Learning API Endpoints | `/api/v1/learning/*` | ✅ Done |
| 3.4 | Tracking API Endpoints | `/api/v1/tracking/*` | ✅ Done |
| 3.5 | Notes API Endpoints | `/api/v1/notes/*` | ✅ Done |
| 3.6 | Projects API Endpoints | `/api/v1/projects/*` | ✅ Done |
| 3.7 | Redis Cache Integration | `cache.py` | ✅ Done |

---

## Phase 4 — DevSecOps (✅ COMPLETED)

| Step | Task | Tool / Input | Status |
|------|------|-------------|--------|
| 4.1 | Multi-stage Dockerfiles (ARM64) | Frontend + Backend | ✅ Done |
| 4.2 | GitHub Actions CI/CD Pipeline | Gitleaks + Semgrep + Trivy | ✅ Done |
| 4.3 | GHCR Container Registry | `docker/build-push-action` | ✅ Done |
| 4.4 | K3s Kubernetes Manifests | Deployments + Ingress | ✅ Done |
| 4.5 | Terraform Cloudflare Tunnel | Zero Trust on-prem exposure | ✅ Done |

---

## Phase 5 — Cinematic Branding (✅ COMPLETED)

| Step | Task | Tool / Input | Status |
|------|------|-------------|--------|
| 5.1 | Logo Integration (mix-blend) | Navbar.tsx | ✅ Done |
| 5.2 | Cinematic Banner Hero | home/page.tsx | ✅ Done |
| 5.3 | Animated Particle Background | ParticleField.tsx (Canvas) | ✅ Done |
| 5.4 | Full Ecosystem Grid Landing | SubdomainGrid.tsx | ✅ Done |
| 5.5 | CSS Scanlines + Vignettes | globals.css | ✅ Done |

---

## Phase 6 — Auth & User Accounts (✅ COMPLETED)

| Step | Task | Tool / Input | Cost | Status |
|------|------|-------------|------|--------|
| 6.1 | Create Supabase Project | [supabase.com](https://supabase.com) | **FREE** | ✅ Done |
| 6.2 | Configure Auth (Email + GitHub OAuth) | Supabase Dashboard | **FREE** | ✅ Done |
| 6.3 | Build Login/Register Pages | Next.js + `@supabase/ssr` | **FREE** | ✅ Done |
| 6.4 | Connect Frontend to Backend JWT | `Authorization: Bearer` header | **FREE** | ✅ Done |
| 6.5 | User Profile + Settings Page | Next.js page + Supabase DB | **FREE** | ✅ Done |

**Input Prompt for this phase:**
> "Act as a Full-Stack Auth Engineer. Implement Supabase authentication in the Next.js frontend with email/password and GitHub OAuth. Create login, register, and profile pages. Connect the frontend JWT to the FastAPI backend for protected API calls."

---

## Phase 7 — Notes Platform (✅ COMPLETED)

| Step | Task | Tool / Input | Cost | Status |
|------|------|-------------|------|--------|
| 7.1 | Obsidian Vault Setup | Local Obsidian + GitHub repo | **FREE** | ✅ Done |
| 7.2 | GitHub Action: Sync Obsidian to DB | `on: push` workflow | **FREE** | ✅ Done |
| 7.3 | Notes Frontend (Markdown Renderer) | `react-markdown` + `rehype` | **FREE** | ✅ Done |
| 7.4 | Search & Filter by Category | FastAPI + PostgreSQL `tsvector` | **FREE** | ✅ Done |
| 7.5 | Cheat Sheet Quick-View Cards | Next.js components | **FREE** | ✅ Done |

**Input Prompt:**
> "Act as a Knowledge Management Engineer. Build a notes platform that syncs an Obsidian markdown vault from GitHub. Render notes with syntax highlighting, search, and category filtering. Categories: SIEM Queries, Detection Rules, MITRE ATT&CK, Cheat Sheets, Runbooks."

---

## Phase 8 — Learning Platform (🔜 NEXT)

| Step | Task | Tool / Input | Cost |
|------|------|-------------|------|
| 8.1 | Course Data Model (Supabase) | `courses`, `lessons`, `progress` tables | **FREE** |
| 8.2 | Course Listing Page | Next.js with cards | **FREE** |
| 8.3 | Lesson Viewer (Markdown + Video) | `react-markdown` + embedded video | **FREE** |
| 8.4 | Progress Tracking API | FastAPI + Supabase | **FREE** |
| 8.5 | Quiz Engine | React state + Supabase scoring | **FREE** |
| 8.6 | Certification Roadmap Visualizer | Mermaid.js or custom SVG | **FREE** |

**Input Prompt:**
> "Act as an EdTech Engineer. Build a cybersecurity learning platform with structured courses, markdown-based lessons, embedded video, quizzes, and progress tracking. Learning paths: Network Security, SOC Analyst, Threat Hunting, DevSecOps, Cloud Security, AI Security."

---

## Phase 9 — Projects Portal (🔜)

| Step | Task | Tool / Input | Cost |
|------|------|-------------|------|
| 9.1 | Project Data Model | `projects`, `steps`, `resources` | **FREE** |
| 9.2 | Interactive 3D Tilt Cards | `react-tilt` or CSS transforms | **FREE** |
| 9.3 | Step-by-Step Tutorial Viewer | Markdown renderer | **FREE** |
| 9.4 | GitHub Repo Integration | GitHub API (public repos) | **FREE** |

**Input Prompt:**
> "Act as a Frontend Engineer. Build an interactive projects portal with 3D tilt cards for each project. Categories: SOC Projects, DevSecOps Projects, Cloud Security Projects, AI Security Projects. Each project has step-by-step tutorials, architecture diagrams, and GitHub links."

---

## Phase 10 — News Aggregator (🔜)

| Step | Task | Tool / Input | Cost |
|------|------|-------------|------|
| 10.1 | RSS Feed Aggregation | Python `feedparser` | **FREE** |
| 10.2 | Scheduled GitHub Action | Cron: every 6 hours | **FREE** |
| 10.3 | News Frontend (Cards + Filters) | Next.js | **FREE** |
| 10.4 | Weekly Digest Email | Supabase Edge Functions | **FREE** |

**Input Prompt:**
> "Act as a Data Engineer. Build an automated cybersecurity news aggregator. Scrape RSS feeds from The Hacker News, BleepingComputer, KrebsOnSecurity, and CISA. Store articles in Supabase. Display with category filters (Security, AI, DevSecOps, Emerging Tech) and a weekly digest feature."

---

## Phase 11 — Personal Dashboard (🔜)

| Step | Task | Tool / Input | Cost |
|------|------|-------------|------|
| 11.1 | Task Management Module | Supabase + React state | **FREE** |
| 11.2 | Finance Tracker Module | Supabase tables | **FREE** |
| 11.3 | Interview Prep Module | Markdown Q&A cards | **FREE** |
| 11.4 | Health Tracker Module | Simple form + charts | **FREE** |
| 11.5 | Career Management Module | Resume versions + job tracker | **FREE** |

**Input Prompt:**
> "Act as a Product Engineer. Build a personal operating system dashboard with modules for: Task Management (daily/weekly/monthly), Finance Tracking (income/expenses/investments), Interview Preparation (SOC/DevOps/Cloud questions), Health Tracking (sleep/water/exercise), and Career Management (resume/job applications)."

---

## Phase 12 — Tracker Dashboard (🔜)

| Step | Task | Tool / Input | Cost |
|------|------|-------------|------|
| 12.1 | Unified Analytics Dashboard | Recharts / Chart.js | **FREE** |
| 12.2 | Connect Learning Progress Data | Supabase joins | **FREE** |
| 12.3 | Connect Project Milestones | Supabase joins | **FREE** |
| 12.4 | Weekly/Monthly Report Generator | PDF export | **FREE** |

**Input Prompt:**
> "Act as a Data Visualization Engineer. Build a unified tracker dashboard that aggregates data from the learning, projects, and personal platforms. Display charts for course completion, certification progress, project milestones, and productivity metrics. Include weekly/monthly report generation."

---

## Phase 13 — Observability & Analytics (🔜)

| Step | Task | Tool / Input | Cost |
|------|------|-------------|------|
| 13.1 | Prometheus Metrics Exporter | FastAPI middleware | **FREE** |
| 13.2 | Grafana Dashboards | Docker on Raspberry Pi | **FREE** |
| 13.3 | Loki Log Aggregation | Lightweight alternative to ELK | **FREE** |

---

## Phase 14 — Community & Gamification (🔜)

| Step | Task | Tool / Input | Cost |
|------|------|-------------|------|
| 14.1 | Discussion Forums | Supabase real-time | **FREE** |
| 14.2 | Leaderboards & Badges | Supabase + React | **FREE** |
| 14.3 | Discord Bot Integration | Discord.js | **FREE** |
| 14.4 | Mentorship Matching | Supabase queries | **FREE** |

---

## Cost Summary

| Resource | Provider | Monthly Cost |
|----------|----------|-------------|
| Compute | Raspberry Pi (On-Prem) | **$0** |
| Database + Auth | Supabase Free Tier | **$0** |
| DNS + CDN + WAF | Cloudflare Free Tier | **$0** |
| Container Registry | GitHub GHCR | **$0** |
| CI/CD Pipeline | GitHub Actions (2000 min/mo) | **$0** |
| Orchestration | K3s (self-hosted) | **$0** |
| Monitoring | Grafana + Prometheus (self-hosted) | **$0** |
| Domain Name | Cloudflare Registrar | **~$10/year** |
| **TOTAL** | | **~$0.83/month** |

> [!TIP]
> **Scale-Up Path:** If you outgrow the Raspberry Pi, Oracle Cloud Free Tier offers 4 ARM64 cores + 24GB RAM for **$0/month**. After that, Hetzner ARM nodes cost only **$5/month** each.

---

## Suggestions & Best Practices

1. **Start with Notes (Phase 7)**. It provides immediate value with minimal effort — just sync your existing Obsidian vault.
2. **Use Supabase Edge Functions** instead of spinning up separate microservices. They run on Deno and are free for up to 500k invocations/month.
3. **Implement Progressive Enhancement**. Ship static pages first (SSG), then layer in interactivity. This keeps your Raspberry Pi from being overwhelmed.
4. **Use GitHub as your CMS**. Store course content, notes, and project tutorials as Markdown files in the repo. Use GitHub Actions to sync them to Supabase on push.
5. **Prioritize SEO from Day 1**. Each subdomain page should have unique meta tags, OpenGraph images, and structured data (JSON-LD) for search engines.
6. **Set up Cloudflare Tunnel immediately**. It eliminates the need for port forwarding, provides free SSL, and hides your home IP address.
7. **Consider using Strapi CMS** (self-hosted on the Pi) for the Learning and News platforms if you want a visual content editor instead of raw Markdown.
