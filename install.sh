#!/usr/bin/env bash
# Richtet diese Claude-Code-Einrichtung auf macOS (oder Linux) ein:
#   1. CLAUDE.md (Startregeln) nach ~/.claude/CLAUDE.md
#   2. Dieses Repository als Plugin-Marketplace "claude-setup"
#   3. Plugins "superpowers" und "marketing" installieren
# Aufruf: aus dem geklonten Repository heraus  ->  bash install.sh
set -euo pipefail

REPO_DIR="$(cd "$(dirname "$0")" && pwd)"
CLAUDE_DIR="$HOME/.claude"

if ! command -v claude >/dev/null 2>&1; then
  echo "Fehler: Die Claude-Code-Kommandozeile 'claude' wurde nicht gefunden." >&2
  echo "Installiere sie zuerst (siehe README.md) und starte dann dieses Skript erneut." >&2
  exit 1
fi

mkdir -p "$CLAUDE_DIR"

# 1. Startregeln
if [ -f "$CLAUDE_DIR/CLAUDE.md" ] && ! cmp -s "$REPO_DIR/CLAUDE.md" "$CLAUDE_DIR/CLAUDE.md"; then
  backup="$CLAUDE_DIR/CLAUDE.md.backup-$(date +%Y%m%d-%H%M%S)"
  cp "$CLAUDE_DIR/CLAUDE.md" "$backup"
  echo "Vorhandene CLAUDE.md gesichert: $backup"
fi
cp "$REPO_DIR/CLAUDE.md" "$CLAUDE_DIR/CLAUDE.md"
echo "Startregeln installiert: $CLAUDE_DIR/CLAUDE.md"

# 2. Marketplace (lokaler Ordner = dieses Repository; Updates per 'git pull')
if claude plugin marketplace list 2>/dev/null | grep -q "claude-setup"; then
  claude plugin marketplace update claude-setup
else
  claude plugin marketplace add "$REPO_DIR"
fi

# 3. Plugins (install aktualisiert bereits installierte Plugins nicht -> danach update)
for plugin in superpowers marketing; do
  claude plugin install "$plugin@claude-setup"
  claude plugin update "$plugin@claude-setup" >/dev/null 2>&1 || true
done

echo
echo "Fertig. Starte Claude Code neu (neue Sitzung), damit die Superpowers-Skills geladen werden."
