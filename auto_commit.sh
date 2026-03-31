#!/bin/bash

# ==============================
# Obsidian Daily Auto Commit
# ==============================

set -e
git config user.name "Obsidian Auto Commit"
git config user.email "auto@obsidian.local"

VAULT="$HOME/Documents/Github/thesis-obsidian"
ENV_FILE="$VAULT/.env"

cd "$VAULT" || exit 1

# ------------------------------
# Check .env exists
# ------------------------------
if [ ! -f "$ENV_FILE" ]; then
    echo ".env file not found."
    exit 1
fi

# ------------------------------
# Load environment variables
# ------------------------------
set -o allexport
source "$ENV_FILE"
set +o allexport

# ------------------------------
# Validate token
# ------------------------------
if [ -z "$GITHUB_TOKEN" ]; then
    echo "GITHUB_TOKEN not set in .env"
    exit 1
fi

if [ -z "$GITHUB_USERNAME" ]; then
    echo "GITHUB_USERNAME not set in .env"
    exit 1
fi

# ------------------------------
# Ensure git repo
# ------------------------------
if [ ! -d ".git" ]; then
    echo "Not a git repository."
    exit 1
fi

# ------------------------------
# Configure authenticated remote
# ------------------------------
REMOTE_URL=$(git config --get remote.origin.url)

# Extract repo path
REPO_PATH=$(echo "$REMOTE_URL" | sed -E 's#https://github.com/##')

AUTH_REMOTE="https://${GITHUB_USERNAME}:${GITHUB_TOKEN}@github.com/${REPO_PATH}"

git remote set-url origin "$AUTH_REMOTE"

# Prevent interactive prompts
export GIT_TERMINAL_PROMPT=0

# ------------------------------
# Commit workflow
# ------------------------------
git add -A

if ! git diff --cached --quiet; then
    COMMIT_MSG="Daily auto commit: $(date '+%Y-%m-%d %H:%M')"
    git commit -m "$COMMIT_MSG"

    git pull --rebase origin main
    git push origin main

    echo "Auto commit completed."
else
    echo "No changes to commit."
fi

# ------------------------------
# Restore clean remote (optional security)
# ------------------------------
git remote set-url origin "https://github.com/${REPO_PATH}"