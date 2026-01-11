# GitHub Setup - Quick Guide

## Step 1: Configure Git (One-Time Setup)

You need to set your GitHub username and email. Run these commands:

```bash
# Set your GitHub username
git config --global user.name "YourGitHubUsername"

# Set your GitHub email (the one you use for GitHub)
git config --global user.email "your.email@example.com"
```

## Step 2: Initialize Repository

```bash
# Initialize git in this project
git init
```

## Step 3: Add Your GitHub Repository

You need your GitHub repository URL. It looks like:
- `https://github.com/YOUR_USERNAME/YOUR_REPO_NAME.git`
- OR `git@github.com:YOUR_USERNAME/YOUR_REPO_NAME.git`

Then run:
```bash
# Add remote (replace with your actual repo URL)
git remote add origin https://github.com/YOUR_USERNAME/YOUR_REPO_NAME.git
```

## Step 4: Verify .env is Protected

```bash
# Check .gitignore includes .env
cat .gitignore | Select-String ".env"
```

## Step 5: Add and Commit Files

```bash
# Add all safe files (respects .gitignore)
git add .

# Check what will be committed (verify no .env)
git status

# Commit
git commit -m "Initial commit: Production-ready secure token contract"
```

## Step 6: Push to GitHub

```bash
# Set main branch
git branch -M main

# Push to GitHub
git push -u origin main
```

---

## Need Help?

**What I need from you:**
1. Your GitHub username
2. Your GitHub email
3. Your repository URL (or repository name if you want me to construct it)

**Then I can help you run the commands!**
