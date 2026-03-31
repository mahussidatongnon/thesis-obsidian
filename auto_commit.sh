#!/bin/bash

# ==============================
# Obsidian Daily Auto Commit
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
# Git author (automation-safe)
# ------------------------------
git config user.name "Obsidian Auto Commit"
git config user.email "auto@obsidian.local"

# ------------------------------
# Authenticated remote (temporary)
# ------------------------------
AUTH_REMOTE="https://${GITHUB_USERNAME}:${GITHUB_TOKEN}@github.com/${GITHUB_REPO}.git"

git remote set-url origin "$AUTH_REMOTE"

export GIT_TERMINAL_PROMPT=0

# ------------------------------
# Commit workflow
# ------------------------------
git add -A

if ! git diff --cached --quiet; then
    COMMIT_MSG="Daily auto commit: $(date '+%Y-%m-%d %H:%M')"

    git commit -m "$COMMIT_MSG"

    git pull --rebase origin "$GITHUB_BRANCH" || true
    git push origin "$GITHUB_BRANCH"

    echo "Auto commit completed."
else
    echo "No changes to commit."
fi

# ------------------------------
# Restore clean remote
# ------------------------------
git remote set-url origin "https://github.com/${GITHUB_REPO}.git"