
# Esportazione Markdown - Script Bash

<!-- TOC -->
- [Descrizione](#descrizione)
- [Script inclusi](#script-inclusi)
- [Requisiti](#requisiti)
- [Installazione](#installazione)
- [Configurazione delle cartelle](#configurazione-delle-cartelle)
- [Come usare](#come-usare)
- [Esempi](#esempi)
- [FAQ](#faq)
- [Licenza](#licenza)
- [Contatti](#contatti)
<!-- TOC -->

## Descrizione

Questa repository contiene due script bash per esportare file Markdown (.md) in vari formati come PDF, EPUB, DOCX, ODT e HTML, con opzioni avanzate per automatizzare l'esportazione.

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
- Dependence per la compilazione PDF: `xelatex` (parte di TeX Live o simili)
- Pacchetti necessari per interfaccia grafica: `kdialog`
- I template personalizzati devono trovarsi nella cartella: `$HOME/scrittura-pandoc/templates`

---

## Installazione

Ecco i comandi base per installare le dipendenze su Ubuntu/Debian:

sudo apt update
sudo apt install pandoc texlive-xetex kdialog

text

Per altre distribuzioni o sistemi, consulta la documentazione ufficiale.

---

## Configurazione delle cartelle

Negli script sono presenti riferimenti a percorsi specifici per template e output, ad esempio:

- Directory template: `$HOME/scrittura-pandoc/templates`
- Directory di output: `$HOME/Esportazioni`

Questi percorsi **possono essere modificati** direttamente negli script per adattarli alla struttura delle tue cartelle.

Assicurati di aggiornare queste variabili se le tue cartelle differiscono da quelle predefinite, per evitare errori durante l’esportazione.

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

## Esempi

- Esporta un solo file Markdown in PDF formato A4 con allineamento a sinistra:

./export.sh a4 pdf documento.md --variable=alignment:left

text

- Esporta più file in formato EPUB:

./export.sh a5 epub file1.md file2.md

text

- Avvia l’interfaccia grafica per esportazioni personalizzate:

./export-gui.sh

text

---

## FAQ

**D: Cosa succede se il percorso dei template non esiste?**  
R: Lo script darà errore. Assicurati che la cartella `$HOME/scrittura-pandoc/templates` esista e contenga i file necessari.

**D: Posso cambiare la cartella di output?**  
R: Sì, modifica la variabile corrispondente negli script per puntare a una cartella a tua scelta.

**D: Perché l’export PDF richiede `xelatex`?**  
R: `xelatex` è il motore PDF usato da `pandoc` per creare PDF di qualità con supporto avanzato di font e formattazione.

---

## Licenza

Questo progetto è sotto licenza GPL-3.0.

---

## Contatti

Per dubbi o suggerimenti apri un issue su GitHub o contatta l'autore.

---t## Strumenti opzionali

Nella cartella della repository è presente anche lo script **update_changelog.sh**, utile per generare in automatico un file `CHANGELOG.md` a partire dai messaggi dei commit Git.

L’uso è del tutto facoltativo: non influisce sul funzionamento di *export.sh* ed *export-gui.sh*.

### Come usarlo
```bash
./update_changelog.sh

