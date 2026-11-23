# claude-setup

Meine Claude-Code-Einrichtung zum Mitnehmen auf andere Rechner:

- **`plugins/superpowers/`**: [Superpowers](https://github.com/obra/superpowers) 7.0.2 (MIT-Lizenz, Jesse Vincent): Skills für Brainstorming, Planung, TDD, systematisches Debugging, Code-Review usw.
- **`CLAUDE.md`**: globale Startregeln (Superpowers-Skills bei passenden Aufgaben benutzen)
- **`.claude-plugin/marketplace.json`**: macht dieses Repository zu einem Claude-Code-Plugin-Marketplace
- **`install.sh`**: richtet alles auf dem Mac ein

## Installation auf dem Mac

1. Claude Code installieren (falls noch nicht vorhanden):
   ```bash
   curl -fsSL https://claude.ai/install.sh | bash
   ```
2. Repository klonen (privat, deshalb mit GitHub-Anmeldung, z. B. über die GitHub CLI):
   ```bash
   brew install gh
   gh auth login
   gh repo clone ben447kreut/claude-setup ~/claude-setup
   ```
3. Einrichten:
   ```bash
   cd ~/claude-setup
   bash install.sh
   ```
4. Claude Code neu starten.

## Aktualisieren

```bash
cd ~/claude-setup
git pull
bash install.sh
```

## Superpowers auf eine neue Version bringen

Neue Version von https://github.com/obra/superpowers herunterladen, den Inhalt von `plugins/superpowers/` damit ersetzen, die Version in `.claude-plugin/marketplace.json` anpassen, committen und pushen.
