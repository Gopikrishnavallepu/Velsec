# Velsec Deployment Guide

This guide will walk you through deploying the Velsec platform for free using **Vercel** (Frontend), **Render** (Backend), and **Supabase** (Database).

## Prerequisites
1. A [GitHub](https://github.com) account.
2. A [Vercel](https://vercel.com) account.
3. A [Render](https://render.com) account.
4. A [Supabase](https://supabase.com) account.

---

## 1. Push Code to GitHub
1. Open your terminal in the project root (`d:\Velsec\velsec-org`).
2. Add your GitHub repository as a remote (if not already done):
   ```bash
   git remote add origin https://github.com/your-username/velsec-org.git
   ```
3. Commit and push the code:
   ```bash
   git add .
   git commit -m "Prepare for Vercel and Render deployment"
   git push -u origin main
   ```

---

## 2. Deploy Database (Supabase)
1. Go to your [Supabase Dashboard](https://app.supabase.com) and create a new project.
2. Once the project is provisioned, go to **Project Settings -> API** to retrieve your `URL` and `anon public` keys.
3. Go to **Project Settings -> Database** to retrieve your PostgreSQL connection string (URI).
4. Save these values, as you will need them for both the Backend and Frontend.

---

## 3. Deploy Backend (Render)
Render offers a very generous free tier for web services and natively supports the `render.yaml` infrastructure-as-code file included in this repository.

1. Go to your [Render Dashboard](https://dashboard.render.com).
2. Click **New +** and select **Blueprint**.
3. Connect your GitHub account and select the `velsec-org` repository.
4. Render will automatically detect the `render.yaml` file and prepare the `velsec-backend` service.
5. Click **Apply**.
6. Render will ask you to fill in the missing environment variables (`sync: false` in `render.yaml`). Provide them:
   - `SUPABASE_URL`: Your Supabase Project URL.
   - `SUPABASE_KEY`: Your Supabase anon public key.
   - `SUPABASE_JWT_SECRET`: Your Supabase JWT secret (from Settings -> API).
   - `DATABASE_URL`: Your Supabase PostgreSQL connection string.
   - `REDIS_URL`: (Optional) If you have a free Redis instance (e.g., from Upstash), put it here. Otherwise, leave it or use a dummy value if your app handles missing Redis gracefully.
7. Click **Deploy**. Render will build the Docker container and start your FastAPI backend.
8. Once deployed, copy the Render URL (e.g., `https://velsec-backend.onrender.com`).

---

## 4. Deploy Frontend (Vercel)
1. Go to your [Vercel Dashboard](https://vercel.com/dashboard).
2. Click **Add New... -> Project**.
3. Import the `velsec-org` repository from GitHub.
4. **IMPORTANT Configuration:**
   - In the "Framework Preset", it should automatically detect Next.js.
   - In the **Root Directory**, click "Edit" and select `frontend`.
5. Open the **Environment Variables** section and add the following:
   - `NEXT_PUBLIC_SUPABASE_URL`: Your Supabase Project URL.
   - `NEXT_PUBLIC_SUPABASE_ANON_KEY`: Your Supabase anon public key.
   - `NEXT_PUBLIC_API_URL`: Your Render Backend URL (e.g., `https://velsec-backend.onrender.com`). Note: Do NOT add a trailing slash.
6. Click **Deploy**.

## Conclusion
Your Velsec platform is now fully deployed! 
- The Next.js frontend is served globally via Vercel's Edge Network.
- The FastAPI backend runs on a Render free-tier container.
- The Postgres database and Authentication are handled securely by Supabase.
