#!/bin/bash

export DISPLAY=:0
export DBUS_SESSION_BUS_ADDRESS="unix:path=/run/user/$(id -u)/bus"

# Modalità operativa
MODE=$(kdialog --radiolist "Modalità operativa:" \
1 "Esporta singolo file" on \
2 "Esporta più file separati" off \
3 "Unisci più file in uno solo" off) || exit 0

# --- INIZIO BLOCCO MODIFICATO ---

# Selezione file: leggiamo l'output in un array per gestire correttamente nomi con spazi.
# kdialog con --separate-output produce un file per riga.
readarray -t FILES_ARRAY < <(kdialog --getopenfilename "$HOME" "*.md" --multiple --separate-output --title "Seleziona file Markdown")

# Se l'utente preme "Annulla", l'array sarà vuoto e lo script terminerà.
if [ ${#FILES_ARRAY[@]} -eq 0 ]; then
    exit 0
fi

# --- FINE BLOCCO MODIFICATO ---

# Formato carta
PAPER_SIZE=$(kdialog --radiolist "Formato carta:" \
a4 "A4" on \
a5 "A5" off \
letter "Letter" off) || exit 0

# Selezione multipla formati output
FORMATS_SELECTED=$(kdialog --checklist "Scegli i formati di output:" \
pdf "PDF" on \
epub "EPUB" off \
docx "Word" off \
odt "OpenOffice" off \
html "HTML" off) || exit 0

# Rimuovo virgolette doppie dai formati selezionati
FORMATS_SELECTED=$(echo $FORMATS_SELECTED | sed 's/"//g')

# Numerazione automatica (solo per PDF e HTML)
NUMBERING=""
if [[ "$FORMATS_SELECTED" =~ pdf|html ]]; then
  if kdialog --yesno "Numerare automaticamente i capitoli?\n(Solo per documenti tecnici/accademici)\n\nPer narrativa: scegli NO"; then
    NUMBERING="--number-sections"
  else
    NUMBERING="--variable=numbersections:false"
  fi
fi

# Opzioni avanzate su allineamento/sillabazione solo se formati PDF o HTML
if [[ "$FORMATS_SELECTED" =~ pdf || "$FORMATS_SELECTED" =~ html ]]; then
  ALIGNMENT=$(kdialog --radiolist "Allineamento:" \
  left "Sinistra" on \
  justify "Giustificato" off \
  right "Destra" off) || exit 0

  if kdialog --yesno "Abilitare sillabazione automatica?"; then
    HYPHEN="--variable=hyphenate:true"
  else
    HYPHEN=""
  fi
else
  ALIGNMENT="left"
  HYPHEN=""
fi

EXPORT_CMD="/home/alessandro/scrittura-pandoc/export.sh"

for FORMAT in $FORMATS_SELECTED; do
  case "$MODE" in
    1)
      # Usa il primo elemento dell'array
      $EXPORT_CMD "$PAPER_SIZE" "$FORMAT" "${FILES_ARRAY[0]}" $NUMBERING $HYPHEN "--variable=alignment:$ALIGNMENT"
      ;;
    2)
      # Itera su tutti gli elementi dell'array
      for file in "${FILES_ARRAY[@]}"; do
        $EXPORT_CMD "$PAPER_SIZE" "$FORMAT" "$file" $NUMBERING $HYPHEN "--variable=alignment:$ALIGNMENT"
      done
      ;;
    3)
      # Passa l'intero array come lista di argomenti
      $EXPORT_CMD "$PAPER_SIZE" "$FORMAT" --merge "${FILES_ARRAY[@]}" $NUMBERING $HYPHEN "--variable=alignment:$ALIGNMENT"
      ;;
  esac
done

kdialog --passivepopup "Esportazione completata!" 3
