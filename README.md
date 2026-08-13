---
title: MANGA GO
emoji: 📚
colorFrom: yellow
colorTo: red
sdk: docker
app_port: 7860
pinned: false
---

# MANGA GO - Free Manga Reader

Read thousands of manga, webtoons, and comics in your browser. No downloads needed.

## Live Website Links

- **Vercel Landing Page**: [MANGA GO Web App](https://mangago-web-main.vercel.app)
- **Direct Reader Library**: [MANGA GO Library](https://rahulae161-mangagohg.hf.space/library)
- **Browse Catalog**: [MANGA GO Browse Catalog](https://rahulae161-mangagohg.hf.space/browse)

## Features

- **1,000+ Manga Sources**: Keiyoushi Extension Store integrated with Tachiyomi Extension API v1.6 support.
- **Zero Downloads**: Read directly in browser without installing apps or downloading files.
- **Always Free**: Unlimited access to all titles and genres.
- **Auto-Updates**: Server stays current with latest Suwayomi preview releases and GitHub Actions pipeline.

## Tech Stack & Architecture

- **Backend / Engine**: Suwayomi Server v2.3 Preview (`ghcr.io/suwayomi/suwayomi-server:preview`) hosted on Hugging Face Spaces.
- **Extensions Store**: Keiyoushi Repositories (`https://raw.githubusercontent.com/keiyoushi/extensions/repo/index.min.json`).
- **UI Customization**: Embedded CSS/JS injection engine (`mangago-inject.css`, `mangago-inject.js`).
- **Web Landing Page**: Vercel Static Hosting with responsive glassmorphism interface (`index.html`).

Developed by **RAHUL CHANDRA**
