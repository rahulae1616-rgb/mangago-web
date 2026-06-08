# MANGA GO Web Application Cloud Deployment Guide

This folder contains the Docker configuration to run **MANGA GO** (powered by the Suwayomi manga engine) on the web. It is fully pre-configured to bind to dynamic cloud ports and pre-registers the **Keiyoushi** extension repository for direct browser reading from anywhere.

---

## Prerequisites
1. A **GitHub** account.
2. A free account on **Render** (https://render.com) or **Railway** (https://railway.app) or **Zeabur** (https://zeabur.com).

---

## Step 1: Upload to GitHub
1. Create a new repository on your GitHub account called `mangago-web`.
2. Push the contents of the `mangago-web-deployment` folder (containing the `Dockerfile`, `server.conf`, and `startup.sh`) to the repository:
   ```bash
   git init
   git add .
   git commit -m "Initialize MANGA GO web deployment"
   git remote add origin https://github.com/YOUR_USERNAME/mangago-web.git
   git branch -M main
   git push -u origin main
   ```

---

## Step 2: Deploy to the Cloud

Choose one of the following cloud hosting providers:

### Option A: Deploy on Render (Recommended Free Tier)
1. Log in to [Render Dashboard](https://dashboard.render.com).
2. Click **New +** and select **Web Service**.
3. Connect your GitHub account and select your `mangago-web` repository.
4. Set the following settings:
   * **Name**: `mangago-web`
   * **Runtime**: `Docker` (Render automatically detects the `Dockerfile`)
   * **Instance Type**: Select **Free** (or a paid instance if you want persistent storage downloads).
5. Click **Deploy Web Service**. Render will build the container and provide a live URL (e.g., `https://mangago-web.onrender.com`).

---

### Option B: Deploy on Railway (Ultra Fast Setup)
1. Log in to [Railway](https://railway.app).
2. Click **New Project** -> **Deploy from GitHub repo**.
3. Select your `mangago-web` repository.
4. Click **Deploy Now**.
5. Once deployed, go to the service **Settings** tab and click **Generate Domain** under the networking section to get your public URL.

---

### Option C: Deploy on Zeabur
1. Log in to [Zeabur](https://zeabur.com).
2. Create a new project, click **Deploy Service**, and select **GitHub**.
3. Select your `mangago-web` repository.
4. Zeabur will automatically build and deploy the container.
5. In the service dashboard, click **Generate Domain** or link a custom domain to get your web app link.

---

## Post-Deployment Config
Once the deployment completes and you open your public link in the browser:
1. Go to **Browse** -> **Extensions** on the web interface.
2. Search and install **WeebCentral**, **Asura Scans**, or any other preferred sources.
3. Start reading manga directly in your browser!
