#!/bin/bash

export DISPLAY=:0
export DBUS_SESSION_BUS_ADDRESS="unix:path=/run/user/$(id -u)/bus"

# Modalità operativa
MODE=$(kdialog --radiolist "Modalità operativa:" \
1 "Esporta singolo file" on \
2 "Esporta più file separati" off \
3 "Unisci più file in uno solo" off) || exit 0

# Selezione file
FILES=$(kdialog --getopenfilename "$HOME" "*.md" --multiple --separate-output --title "Seleziona file Markdown") || exit 0

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
      firstfile=$(echo $FILES | head -n 1)
      $EXPORT_CMD "$PAPER_SIZE" "$FORMAT" "$firstfile" $HYPHEN "--variable=alignment:$ALIGNMENT"
      ;;
    2)
      for file in $FILES; do
        $EXPORT_CMD "$PAPER_SIZE" "$FORMAT" "$file" $HYPHEN "--variable=alignment:$ALIGNMENT"
      done
      ;;
    3)
      $EXPORT_CMD "$PAPER_SIZE" "$FORMAT" --merge $FILES $HYPHEN "--variable=alignment:$ALIGNMENT"
      ;;
  esac
done

kdialog --passivepopup "Esportazione completata!" 3
