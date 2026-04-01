# 📚 Obsidian Vault Auto-Commit Setup

This repository includes a script to **automatically commit and push changes** from your Obsidian vault to GitHub on a daily basis. It uses a **Personal Access Token** stored in a `.env` file for authentication. This guide covers **all steps** from setup to running the script.

---

## 🔧 1. Prerequisites

Before starting, make sure you have:

* macOS with Git installed
* A GitHub account with a repository for this vault
* A Personal Access Token (PAT), **fine-grained token recommended**, starting with `github_pat_`

---

## ⚙️ 2. Prepare the `.env` file

1. Copy the example environment file:

```bash
cp env_example .env
```

2. Open `.env` in a text editor and fill in your details:

```bash
GITHUB_TOKEN=github_pat_xxxxxxxxxxxxx
GITHUB_USERNAME=your-username
GITHUB_REPO=your-username/thesis-obsidian
GITHUB_BRANCH=main
```

* `GITHUB_TOKEN` → your GitHub Personal Access Token
* `GITHUB_USERNAME` → your GitHub username
* `GITHUB_REPO` → repository in `username/repo` format
* `GITHUB_BRANCH` → branch to push (default: `main`)

**⚠️ Important:**

* Never commit `.env` to Git. Make sure `.gitignore` contains:

```
.env
```

---

## 🛠 3. Overview of the Script

The script `auto_commit.sh`:

* Loads the `.env` file
* Initializes the Git repository if missing
* Adds and commits changes daily
* Pushes to GitHub using the token
* Restores original remote URL and Git config

It is safe to run manually or automatically via macOS `launchd`.

---

## 💻 4. Manual Run

After configuring `.env`, test the script manually:

```bash
cd ~/Documents/Github/thesis-obsidian
./auto_commit.sh
```

* If there are changes: they will be committed and pushed
* If there are no changes: it will print `No changes to commit.`

---

## ⏰ 5. Automate Daily Commits with macOS `launchd` (not stable yet)

1. Create a LaunchAgent file at:

```
~/Library/LaunchAgents/com.obsidian.autocommit.plist
```

Contents:

```xml
<?xml version="1.0" encoding="UTF-8"?>
<!DOCTYPE plist PUBLIC "-//Apple//DTD PLIST 1.0//EN"
"http://www.apple.com/DTDs/PropertyList-1.0.dtd">

<plist version="1.0">
<dict>
    <key>Label</key>
    <string>com.obsidian.autocommit</string>

    <key>ProgramArguments</key>
    <array>
        <string>/Users/YOUR_USERNAME/Documents/Github/thesis-obsidian/auto_commit.sh</string>
    </array>

    <key>StartCalendarInterval</key>
    <dict>
        <key>Hour</key>
        <integer>23</integer>
        <key>Minute</key>
        <integer>0</integer>
    </dict>

    <key>StandardOutPath</key>
    <string>/tmp/obsidian_autocommit.log</string>

    <key>StandardErrorPath</key>
    <string>/tmp/obsidian_autocommit_error.log</string>
</dict>
</plist>
```

2. Load the LaunchAgent:

```bash
launchctl load ~/Library/LaunchAgents/com.obsidian.autocommit.plist
```

* Script will run **daily at 23:00**
* Logs stored in `/tmp/obsidian_autocommit.log` and `/tmp/obsidian_autocommit_error.log`

---

## ✅ 6. Optional Notes

* You can still commit manually anytime:

```bash
git add .
git commit -m "Manual commit: update notes"
git push
```

* Recommended: Ignore workspace layout changes (e.g., `.obsidian/workspace.json`) to prevent unnecessary commits.

---

## 📄 7. Troubleshooting

* **Author identity unknown:**
  Run once to set local Git identity:

```bash
git config user.name "Obsidian Auto Commit"
git config user.email "auto@obsidian.local"
```

* **Authentication errors:**
  Make sure `.env` contains a valid `GITHUB_TOKEN` with **repo write access**.

* **No changes committed:**
  Script only commits if files actually changed.

---

## 📝 8. Example Commit (Test)

After configuring `.env`, you can test a manual commit:

```bash
cd ~/Documents/Github/thesis-obsidian
./auto_commit.sh
```

Expected output if changes exist:

```
Auto commit completed.
```

Commit message example:

```
Daily auto commit: 2026-03-31 23:00
```

If no changes exist:

```
No changes to commit.
```

---

## 🔐 9. Security Reminder

* Keep `.env` out of version control
* Do **not** store your token directly in the script
* The script temporarily uses the token for pushing and restores the original remote URL and Git configuration afterward

---

## 🏁 10. Notes for Advanced Users

* You can ignore Obsidian workspace files to avoid unnecessary commits
* Script supports **SSH or HTTPS remotes**
* Local Git config (`user.name` and `user.email`) is restored after each run
* Safe for daily unattended automation
