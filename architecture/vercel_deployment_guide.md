# Velsec Deployment Guide: Vercel & Container Infrastructure

This document outlines the deployment strategy for the Velsec Cybersecurity Ecosystem. It explains what Vercel is, why we use it, how it helps, and details how to deploy the Next.js frontend alongside the FastAPI backend.

---

## Part 1: Vercel - What, Why, and How it Helps

### 1. What is Vercel?
Vercel is a serverless cloud deployment and hosting platform optimized for frontend frameworks (created by the authors of Next.js) and serverless backend functions.

### 2. Why do we use it?
* **Cost Efficiency:** It offers a highly generous free tier ($0/month) for individual developers and startup hobby projects.
* **Instant CI/CD:** By linking directly with GitHub, Vercel triggers a production build and deployment automatically on every `git push`.
* **Subdomain Management:** It provides native support for mapping custom apex domains and wildcard subdomains (`*.yourdomain.com`), which is critical for Velsec's multi-subdomain architecture.

### 3. How does it help us?
* **Zero Server Overhead:** Vercel eliminates the need to manage virtual machines, configure Nginx reverse proxies, write cron jobs, or handle manual SSL/TLS certificates.
* **Global Speed:** Content is statically optimized and delivered via Vercel's global Edge CDN, ensuring sub-second response times for users.

---

## Part 2: All-on-Vercel Deployment Compatibility

It is possible to deploy both the **Next.js Frontend** and the **FastAPI Backend** entirely on Vercel by utilizing Vercel's **Python Serverless Functions**.

### Feasibility Matrix

| Feature Area | Supported on Vercel? | Notes & Mitigations |
| :--- | :--- | :--- |
| **Next.js Frontend UI** | **Yes (100%)** | Native platform execution. |
| **Supabase Authentication** | **Yes (100%)** | Secure, cross-subdomain cookies work automatically. |
| **FastAPI REST API Routes** | **Yes (100%)** | Backend routes are compiled into serverless Python execution layers. |
| **Obsidian Sync Pipeline** | **Yes (100%)** | Sync script POSTs directly to the Vercel serverless API endpoint. |
| **PostgreSQL Database** | **Yes (100%)** | Backend queries the cloud-based Supabase PostgreSQL instance. |
| **Redis Caching** | **Yes (With Cloud Redis)** | Ephemeral serverless environments cannot host a local Redis process. You must connect the backend configuration (`REDIS_URL`) to a cloud-based serverless Redis service like **Upstash** (free tier available). |
| **Interactive SOC Labs (Phase 9+)** | **No** | Ephemeral serverless functions cannot run a Docker daemon or manage Kubernetes namespaces to spin up target lab containers. Interactive threat emulation labs will still require a dedicated container host (e.g., Render, Railway, or VPS). |

---

## Part 3: Deploying Next.js & FastAPI Entirely on Vercel

To configure Vercel to route backend requests to FastAPI and let Next.js handle the frontend natively, add a `vercel.json` configuration in your repository root:

#### `vercel.json`
```json
{
  "version": 2,
  "rewrites": [
    {
      "source": "/api/(.*)",
      "destination": "backend/app/main.py"
    }
  ],
  "builds": [
    {
      "src": "backend/app/main.py",
      "use": "@vercel/python"
    },
    {
      "src": "frontend/package.json",
      "use": "@vercel/next"
    }
  ]
}
```

* Vercel compiles your FastAPI routes into serverless Python execution layers under `/api/*`.
* All non-API traffic is handled natively by the Next.js frontend, which automatically compiles and executes `frontend/src/proxy.ts` as the routing/auth proxy (matching the Next.js 16+ convention).
* Vercel will detect `backend/requirements.txt` automatically and install all Python dependencies inside the serverless functions during build time.

---

## Part 4: Step-by-Step Vercel Deployment & Supabase Auth Setup

Follow these exact steps to deploy the local monorepo code to Vercel and configure shared subdomain authentication.

### Step 1: Set Up Your Supabase Cloud Project
Before deploying, you need a live database and authentication provider in the cloud.

1. Go to [supabase.com](https://supabase.com) and create a free project.
2. In the Supabase Dashboard, go to **Project Settings > API** and copy:
   * **Project URL**
   * **Anon Key** (Public API Key)
   * **Service Role Key** (Secret API Key)
3. Scroll down to **JWT Settings** and copy the **JWT Secret** (used by FastAPI to verify cookies).

### Step 2: Push Local Code to GitHub
Vercel integrates directly with GitHub to trigger automatic builds. Since your repository is already linked to the GitHub remote `https://github.com/Gopikrishnavallepu/VelSec.git`, you simply need to commit and push your local changes:

1. Open your terminal in the root folder (`d:\Velsec\velsec-org`).
2. Run the following commands to stage, commit, and push your changes:
   ```powershell
   git add .
   git commit -m "deploy: vercel monorepo configuration with serverless FastAPI and proxy"
   git push origin main
   ```

### Step 3: Deploy on Vercel
1. Log in to [Vercel](https://vercel.com).
2. Click **Add New > Project** and import your `velsec-org` repository.
3. In the **Configure Project** settings:
   * Leave the **Root Directory** as the root (`/`) (Vercel will use the `vercel.json` we created at the root to build both folders).
4. Expand the **Environment Variables** section and add the following:

| Key | Value | Used By |
| :--- | :--- | :--- |
| `NEXT_PUBLIC_SUPABASE_URL` | `https://your-project.supabase.co` | Frontend (Auth Client) |
| `NEXT_PUBLIC_SUPABASE_ANON_KEY` | `your-public-anon-key` | Frontend (Auth Client) |
| `NEXT_PUBLIC_COOKIE_DOMAIN` | `.yourdomain.com` | Frontend (Shared Cookies) |
| `SUPABASE_URL` | `https://your-project.supabase.co` | Backend (FastAPI Client) |
| `SUPABASE_KEY` | `your-service-role-key` | Backend (FastAPI Client) |
| `SUPABASE_JWT_SECRET` | `your-jwt-secret` | Backend (JWT Verification) |
| `SYNC_API_KEY` | `your-secure-sync-key-here` | Notes Sync script |

5. Click **Deploy**. Vercel will build Next.js and compile your FastAPI Python backend into edge-routed Serverless Functions automatically.

### Step 4: Configure Custom Wildcard Domains on Vercel
Because the authentication proxy shares sessions between `notes.yourdomain.com` and `yourdomain.com`, you need to set up your domain.

1. In the Vercel project dashboard, go to **Settings > Domains**.
2. Add your custom apex domain: `yourdomain.com`.
3. Add a wildcard domain: `*.yourdomain.com` (this routes all subdomains like `notes` and `learn` to the same deployment).
4. Point your domain DNS records at your registrar (GoDaddy, Namecheap, Cloudflare, etc.) to the Vercel IPs provided in the console.

### Step 5: Configure Supabase Redirects for Subdomains
Supabase Auth needs to know which domains are allowed to handle authentication redirects.

1. Go to your **Supabase Dashboard**.
2. Go to **Auth > URL Configuration**.
3. Set your **Site URL** to:
   `https://yourdomain.com` (or `https://www.yourdomain.com`)
4. Add the following redirect patterns to the **Redirect URLs** list:
   * `https://*.yourdomain.com/*`
   * `https://notes.yourdomain.com/*`
   * `https://learn.yourdomain.com/*`
   * `https://yourdomain.com/*`
5. Save changes. 

### Step 6: Log In and Test
Once DNS propagates:
1. Navigate to: `https://yourdomain.com/register` to create an account.
2. Log in at: `https://yourdomain.com/login`.
3. Once authenticated, navigate directly to: `https://notes.yourdomain.com` — your session cookie will be active, and you will have secure access to the notes platform!

---

## Part 5: Alternative Production Setup (Next.js on Vercel + Backend on Containers)

If you plan to utilize advanced Docker/Kubernetes emulations, host the frontend on Vercel and run the FastAPI backend inside a container (Render, Railway, or VPS).

### 1. Frontend Configuration (Vercel)
1. Import the repository on Vercel.
2. Set the **Root Directory** to `frontend`.
3. Add the following environment variables:
   * `NEXT_PUBLIC_SUPABASE_URL`: Supabase project URL.
   * `NEXT_PUBLIC_SUPABASE_ANON_KEY`: Supabase anon key.
   * `NEXT_PUBLIC_COOKIE_DOMAIN`: `.yourdomain.com` (starts with dot).
   * `NEXT_PUBLIC_API_URL`: `https://api.yourdomain.com` (backend container URL).
4. Map `yourdomain.com` and `*.yourdomain.com` (wildcard) under **Settings > Domains**.

### 2. Backend Configuration (Docker Container)
1. Set up GitHub Actions to push the backend container to GHCR (configured in `.github/workflows/`).
2. Deploy the image `ghcr.io/your_username/velsec-backend:latest` to Render, Railway, or Fly.io.
3. Configure environment variables in your container console:
   * `SUPABASE_URL` / `SUPABASE_KEY` / `SUPABASE_JWT_SECRET`
   * `SYNC_API_KEY`: Matching secret key for Obsidian note uploads.
   * `DATABASE_URL`: Connection string to Supabase PostgreSQL database.
   * `REDIS_URL`: Caching instance URL.
4. Set execution port to `8000`.

### 3. Obsidian Sync Actions
1. Run the database schema in Supabase SQL editor:
   [notes_schema.sql](file:///d:/Velsec/velsec-org/architecture/notes_schema.sql)
2. Add secrets `VELSEC_API_URL` and `SYNC_API_KEY` to GitHub.
3. Push Markdown files to `notes-vault/` to automatically trigger [sync_notes.py](file:///d:/Velsec/velsec-org/scripts/sync_notes.py) and update the wiki records.
