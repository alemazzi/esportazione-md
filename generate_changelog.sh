#!/bin/bash

# File di output
CHANGELOG="CHANGELOG.md"

# Intestazione iniziale
echo "# Changelog" > "$CHANGELOG"
echo "Tutte le modifiche rilevanti a questo progetto saranno documentate in questo file." >> "$CHANGELOG"
echo "Formato ispirato a Keep a Changelog: https://keepachangelog.com/it/1.1.0/" >> "$CHANGELOG"
echo "Versionamento SemVer: https://semver.org/lang/it/" >> "$CHANGELOG"
echo "" >> "$CHANGELOG"
echo "## [Unreleased]" >> "$CHANGELOG"
echo "- Inserisci qui le modifiche non ancora rilasciate" >> "$CHANGELOG"
echo "" >> "$CHANGELOG"

# Legge i tag in ordine cronologico inverso
git tag --sort=-creatordate | while read tag; do
    TAG_DATE=$(git log -1 --format=%ad --date=short "$tag")
    echo "## [$tag] - $TAG_DATE" >> "$CHANGELOG"
    echo "" >> "$CHANGELOG"
    # Estrae i messaggi dei commit fino al tag precedente
    PREV_TAG=$(git tag --sort=-creatordate | grep -A1 "^${tag}$" | tail -n1)
    if [ -z "$PREV_TAG" ]; then
        # Nessun tag precedente, prende tutti i commit fino all'inizio
        git log --pretty=format:"- %s (%an)" "$tag" --not --all >> "$CHANGELOG"
    else
        git log --pretty=format:"- %s (%an)" "$PREV_TAG..$tag" >> "$CHANGELOG"
    fi
    echo "" >> "$CHANGELOG"
done

echo "CHANGELOG.md generato con successo!"
