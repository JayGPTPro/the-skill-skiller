#!/usr/bin/env bash
# package-skill.sh - packages a built skill into a zip file for sharing (Mac/Linux)
# Usage: ./package-skill.sh <skill-name>
# Assumes the skill is already installed at ~/.claude/skills/<skill-name>/
set -euo pipefail

SKILL_NAME="${1:-}"
if [ -z "$SKILL_NAME" ]; then
  echo "Error: missing skill name. Usage: ./package-skill.sh <skill-name>"
  exit 1
fi

SKILLS_DIR="$HOME/.claude/skills"
SRC="$SKILLS_DIR/$SKILL_NAME"
if [ ! -d "$SRC" ]; then
  echo "Error: skill '$SKILL_NAME' not found at $SRC"
  exit 1
fi

# Output directory for share packages, on the Desktop
OUT_DIR="$HOME/Desktop/the-skill-skiller-packages"
mkdir -p "$OUT_DIR"
ZIP_PATH="$OUT_DIR/$SKILL_NAME.zip"

# Package the skill folder (including the injected install-README and install-prompt)
rm -f "$ZIP_PATH"
( cd "$SKILLS_DIR" && zip -r -q "$ZIP_PATH" "$SKILL_NAME" -x "*.DS_Store" )

echo "✅ Created: $ZIP_PATH"
echo "$ZIP_PATH"
