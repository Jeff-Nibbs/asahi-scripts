#!/usr/bin/env bash


# ===== Config =====
REPO_PATH="/home/mrmans/asahi-scripts/"
BRANCH="main"

# ===== Go to repo =====
cd "$REPO_PATH" || { echo "❌ Repo not found at $REPO_PATH"; exit 1; }

# ===== Determine Emoji Based on File Types =====
if git diff --name-only | grep -E '\.(js|ts|py|sh|rb|go|cpp|c)$' > /dev/null; then
  EMOJI="✨"   # New feature or code changes
elif git diff --name-only | grep -E '\.(html|css|scss|sass|svg)$' > /dev/null; then
  EMOJI="💄"   # Style/UI
elif git diff --name-only | grep -E 'README|\.md$' > /dev/null; then
  EMOJI="📝"   # Docs
elif git diff --name-only | grep -E '\.(json|yml|yaml|conf|ini|txt)$' > /dev/null; then
  EMOJI="🧰"   # Config
elif git diff --name-only | grep -E '\.(png|jpg|jpeg|gif|webp|ico)$' > /dev/null; then
  EMOJI="🖼️"   # Image assets
elif git diff --name-only | grep -E 'delete|remove|rm' > /dev/null; then
  EMOJI="🔥"   # Deletion
else
  # Random fallback emoji
  EMOJIS=("💾" "🧹" "🚀" "🔧" "🐛" "🧪" "📦")
  EMOJI=${EMOJIS[$RANDOM % ${#EMOJIS[@]}]}
fi

# ===== Commit Message with Emoji =====
COMMIT_MSG="$EMOJI Auto-commit on $(date '+%Y-%m-%d %H:%M:%S')"

# ===== Git status check =====
if git diff --quiet && git diff --cached --quiet; then
  echo "✅ No changes to commit."
  exit 0
fi
# ===== Stage and commit =====
git status

git add .

git commit -m "$COMMIT_MSG"

# ===== Push using SSH =====
git push origin "$BRANCH"

# ===== Done =====
echo "✅ Pushed changes to $BRANCH at $(date)"
