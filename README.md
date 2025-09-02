# Esportazione Markdown - Script Bash

<!-- TOC -->

🇬🇧 [English version](README_EN.md)

- [Descrizione](#descrizione)
- [Script inclusi](#script-inclusi)
- [Requisiti](#requisiti)
- [Installazione](#installazione)
- [Configurazione delle cartelle](#configurazione-delle-cartelle)
- [Come usare](#come-usare)
- [Esempi](#esempi)
- [FAQ](#faq)
- [File Desktop per Avvio Rapido](#file-desktop-per-avvio-rapido)
- [Strumenti opzionali](#strumenti-opzionali)
- [Compatibilità](#compatibilit%C3%A0)
- [Licenza](#licenza)
- [Contatti](#contatti)

## Descrizione

Questa repository contiene due script bash per esportare file Markdown (.md) in vari formati come PDF, EPUB, DOCX, ODT e HTML, con opzioni avanzate per automatizzare l'esportazione.

## Script inclusi

- **export.sh**  
  Script da linea di comando per esportare uno o più file Markdown in diversi formati, con supporto per:  
  - scelta del formato di output (pdf, epub, docx, odt, html)  
  - selezione della dimensione carta (A4, A5, Letter)  
  - opzioni avanzate come allineamento testo, sillabazione, unione di più file in uno solo

- **export-gui.sh**  
  Interfaccia grafica basata su kdialog per selezionare modalità di esportazione, formati di output, dimensione carta e file Markdown da esportare con un semplice wizard.

## Requisiti

- pandoc installato e configurato nel sistema  
- dipendenze per la compilazione PDF: xelatex (parte di TeX Live o simili)  
- pacchetti necessari per interfaccia grafica: kdialog  
- i template personalizzati devono trovarsi nella cartella: `$HOME/scrittura-pandoc/templates`

## Installazione

Ecco i comandi base per installare le dipendenze su Ubuntu/Debian:

```bash
sudo apt update
sudo apt install pandoc texlive-xetex kdialog
```

Per altre distribuzioni o sistemi, consulta la documentazione ufficiale.

## Configurazione delle cartelle

Negli script sono presenti riferimenti a percorsi specifici per template e output, ad esempio:

- Directory template: `$HOME/scrittura-pandoc/templates`
- Directory di output: `$HOME/Esportazioni`

Questi percorsi possono essere modificati direttamente negli script per adattarli alla struttura delle tue cartelle.
Assicurati di aggiornare queste variabili se le tue cartelle differiscono da quelle predefinite, per evitare errori durante l’esportazione.

## Come usare

## Da terminale

Per esportare singoli o più file usando lo script di base:

```
bash
./export.sh a4 pdf file1.md file2.md --variable=alignment:left
```

## Con interfaccia grafica

Per lanciare lo script con wizard grafico:

```
bash
./export-gui.sh
```

## Esempi

- Esporta un solo file Markdown in PDF formato A4 con allineamento a sinistra:

  ```
  bash
  ./export.sh a4 pdf documento.md --variable=alignment:left
  ```

- Esporta più file in formato EPUB:

  ```
  bash
  ./export.sh a5 epub file1.md file2.md
  ```

- Avvia l’interfaccia grafica per esportazioni personalizzate:

  ```
  bash
  ./export-gui.sh
  ```

## FAQ

**D: Cosa succede se il percorso dei template non esiste?**
R: Lo script darà errore. Assicurati che la cartella `$HOME/scrittura-pandoc/templates` esista e contenga i file necessari.

**D: Posso cambiare la cartella di output?**
R: Sì, modifica la variabile corrispondente negli script per puntare a una cartella a tua scelta.

**D: Perché l’export PDF richiede xelatex?**
R: xelatex è il motore PDF usato da pandoc per creare PDF di qualità con supporto avanzato di font e formattazione.

## File Desktop per Avvio Rapido

Nel file `extras/esportazione-markdown.desktop` è presente un file desktop pronto all'uso per avviare l'interfaccia grafica di esportazione Markdown.
Per usarlo, copia il file desktop nella tua cartella `~/.local/share/applications/` e rendilo eseguibile con:

```
bash
chmod +x ~/.local/share/applications/esportazione-markdown.desktop
```

Assicurati che il percorso in `Exec=` nel file desktop corrisponda al percorso dello script `export-gui.sh`.
Questo permette un facile avvio da menu o desktop environment.

## Strumenti opzionali

Nella cartella della repository è presente anche lo script `update_changelog.sh`, utile per generare in automatico un file `CHANGELOG.md` a partire dai messaggi dei commit Git.
L’uso è del tutto facoltativo: non influisce sul funzionamento di `export.sh` ed `export-gui.sh`.

## Come usarlo

```
bash
./update_changelog.sh
```

## Compatibilità

Questo progetto è stato sviluppato e testato su sistemi Linux (ad esempio Nobara, Fedora, Ubuntu).
Gli script e i file sono destinati all’uso in ambienti Linux con shell Bash e strumenti Linux standard.
L’uso su Windows o macOS richiede adattamenti o ambienti specifici (es. WSL su Windows).

## Licenza

Questo progetto è sotto licenza GPL-3.0.

## Contatti

Per dubbi o suggerimenti apri un issue su GitHub o contatta l'autore.
