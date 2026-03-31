#!/bin/bash
# ==============================
# Obsidian Daily Auto Commit (robust)
# ==============================

set -e

VAULT="$HOME/Documents/Github/thesis-obsidian"
ENV_FILE="$VAULT/.env"

cd "$VAULT" || exit 1

# ------------------------------
# Load .env
# ------------------------------
if [ ! -f "$ENV_FILE" ]; then
    echo ".env file not found"
    exit 1
fi

set -o allexport
source "$ENV_FILE"
set +o allexport

# ------------------------------
# Validate required variables
# ------------------------------
if [ -z "$GITHUB_TOKEN" ]; then
    echo "Missing GITHUB_TOKEN"
    exit 1
fi

if [ -z "$GITHUB_USERNAME" ]; then
    echo "Missing GITHUB_USERNAME"
    exit 1
fi

if [ -z "$GITHUB_REPO" ]; then
    echo "Missing GITHUB_REPO"
    exit 1
fi

GITHUB_BRANCH=${GITHUB_BRANCH:-main}

# ------------------------------
# Ensure git repo exists
# ------------------------------
if [ ! -d ".git" ]; then
    echo "Initializing repository..."
    git init
    git branch -M "$GITHUB_BRANCH"
    git remote add origin "https://github.com/$GITHUB_REPO.git"
fi

# ------------------------------
# Backup current remote and local git config
# ------------------------------
ORIGINAL_REMOTE=$(git config --get remote.origin.url || echo "")
ORIGINAL_NAME=$(git config user.name || echo "")
ORIGINAL_EMAIL=$(git config user.email || echo "")

# ------------------------------
# Set automation-safe git config
# ------------------------------
git config user.name "Obsidian Auto Commit"
git config user.email "auto@obsidian.local"

# ------------------------------
# Setup temporary authenticated remote
# ------------------------------
AUTH_REMOTE="https://${GITHUB_USERNAME}:${GITHUB_TOKEN}@github.com/${GITHUB_REPO}.git"

if [ -n "$ORIGINAL_REMOTE" ]; then
    git remote set-url origin "$AUTH_REMOTE"
else
    git remote add origin "$AUTH_REMOTE"
fi

export GIT_TERMINAL_PROMPT=0

# ------------------------------
# Commit workflow
# ------------------------------
git add -A

# Commit if there are staged changes
if ! git diff --cached --quiet; then
    COMMIT_MSG="Daily auto commit: $(date '+%Y-%m-%d %H:%M')"
    git commit -m "$COMMIT_MSG"
    echo "Changes committed locally."
else
    echo "No new changes to commit."
fi

# ------------------------------
# Always push to remote
# ------------------------------
git pull --rebase origin "$GITHUB_BRANCH" || true
git push origin "$GITHUB_BRANCH"
echo "Local commits pushed to remote (if any)."

# ------------------------------
# Restore original remote URL and local git config
# ------------------------------
if [ -n "$ORIGINAL_REMOTE" ]; then
    git remote set-url origin "$ORIGINAL_REMOTE"
fi

if [ -n "$ORIGINAL_NAME" ]; then
    git config user.name "$ORIGINAL_NAME"
else
    git config --unset user.name
fi

if [ -n "$ORIGINAL_EMAIL" ]; then
    git config user.email "$ORIGINAL_EMAIL"
else
    git config --unset user.email
fi