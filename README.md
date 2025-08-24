text
# Esportazione Markdown - Script Bash

Questa repository contiene due script bash per esportare file Markdown (.md) in vari formati come PDF, EPUB, DOCX, ODT e HTML, con opzioni avanzate di automazione.

---

## Script inclusi

### export.sh

Script da linea di comando per esportare uno o più file Markdown in diversi formati, con supporto per:

- Scelta del formato di output (pdf, epub, docx, odt, html)
- Selezione della dimensione carta (A4, A5, Letter)
- Opzioni avanzate come allineamento testo, sillabazione, unione di più file in uno solo

### export-gui.sh

Interfaccia grafica basata su `kdialog` per selezionare modalità di esportazione, formati di output, dimensione carta e file Markdown da esportare con un semplice wizard.

---

## Requisiti

- `pandoc` installato e configurato nel sistema
- Dipendenze per la compilazione PDF: `xelatex` (in genere parte di TeX Live)
- Pacchetti necessari per interfaccia grafica: `kdialog`
- I template personalizzati devono trovarsi nella cartella: `$HOME/scrittura-pandoc/templates`

---

## Come usare

### Da terminale

Per esportare singoli o più file usando lo script di base:

./export.sh a4 pdf file1.md file2.md --variable=alignment:left

text

### Con interfaccia grafica

Per lanciare lo script con wizard grafico:

./export-gui.sh

text

---

## Licenza

Questo progetto è sotto licenza GPL-3.0.

---

## Contatti

Per dubbi o suggerimenti apri un issue su GitHub o contatta l'autore.

---
