#!/bin/bash

# Stelle sicher, dass ein Argument angegeben wurde
if [ $# -eq 0 ]; then
    echo "Bitte gib den Dateinamen der Markdown-Datei an, z.B. ./comment_script.sh Fahrrad.md"
    exit 1
fi

# Setze Variablen
MD_FILE=$1
IFRAME_URL="https://mountaiin-comments.netlify.app/"
GIT_REPO_PATH="$HOME/obsidian/comments"
HTML_TEMPLATE_PATH="$HOME/obsidian/comments/index.html"
HTML_DESTINATION_PATH="$GIT_REPO_PATH/$(basename "$MD_FILE" .md).html"

# Kopiere die HTML-Vorlage und benenne sie mit dem Dateinamen um
cp "$HTML_TEMPLATE_PATH" "$HTML_DESTINATION_PATH"

# Füge den iframe zur Markdown-Datei hinzu
echo >> "$MD_FILE"
echo >> "$MD_FILE"
echo "<iframe src=\"$IFRAME_URL/$(basename "$HTML_DESTINATION_PATH")\" width=\"100%\" height=\"400\" frameborder=\"0\"></iframe>" >> "$MD_FILE"

# Navigiere zum Git-Repo, committe und pushe die Änderungen
cd "$GIT_REPO_PATH"
git add "$(basename "$HTML_DESTINATION_PATH")"
git commit -m "Hinzufügen von $(basename "$HTML_DESTINATION_PATH") für Kommentarbereich"
git push
