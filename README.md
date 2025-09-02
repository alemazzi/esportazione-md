# Esportazione Markdown – Script Bash

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
- [AppImage pronta all’uso](#appimage-pronta-alluso)
- [Compatibilità](#compatibilità)
- [Licenza](#licenza)
- [Contatti](#contatti)

---

## Descrizione

Questa repository contiene **due script Bash** per convertire file Markdown (`.md`) in **PDF, EPUB, DOCX, ODT e HTML**, con opzioni avanzate e un’interfaccia grafica semplice.

---

## Script inclusi

| Script            | Cosa fa                                                      |
| ----------------- | ------------------------------------------------------------ |
| **export.sh**     | Da terminale: esporta uno o più file, scegli formato, dimensione carta, allineamento, sillabazione, unione. |
| **export-gui.sh** | Wizard grafico (kdialog) per selezionare modalità, formati, carta e file da esportare. |

---

## Requisiti

- **pandoc**  (installato a livello di sistema)  
- **xelatex** (per PDF; pacchetto `texlive-xetex`)  
- **kdialog** (per la GUI; su GNOME puoi usare `zenity`)  
- **template personalizzati** in `~/scrittura-pandoc/templates`

---

## Installazione

### Ubuntu / Debian

```bash
sudo apt update
sudo apt install pandoc texlive-xetex kdialog
```

### AppImage (senza installazione)

1. Scarica l’ultima release:
   https://github.com/alemazzi/esportazione-md/releases

2. Rendi eseguibile e avvia:

   bash

   ```bash
   chmod +x Markdown-Export-x86_64.AppImage
   ./Markdown-Export-x86_64.AppImage
   ```
   
   

------

## Configurazione delle cartelle

| Variabile       | Predefinito                    | Scopo              |
| :-------------- | :----------------------------- | :----------------- |
| `TEMPLATES_DIR` | `~/scrittura-pandoc/templates` | template LaTeX/CSS |
| `OUTPUT_DIR`    | `~/Esportazioni`               | cartella di output |

Modifica i percorsi negli script se necessario.

------

## Come usare

### Da terminale

bash

```bash
# PDF A4, allineamento sinistra
./export.sh a4 pdf miofile.md --variable=alignment:left

# EPUB A5
./export.sh a5 epub *.md
```

### Con interfaccia grafica

bash

```bash
./export-gui.sh
```

------

## Esempi rapidi

| Operazione         | Comando                           |
| :----------------- | :-------------------------------- |
| Singolo PDF        | `./export.sh a4 pdf tesi.md`      |
| Unire tutti in PDF | `./export.sh a4 pdf --merge *.md` |
| GUI guidata        | `./export-gui.sh`                 |

------

## FAQ

**D: Il percorso template non esiste?**
A: Crea la cartella `~/scrittura-pandoc/templates` e inserisci i file richiesti.

**D: Posso cambiare la cartella di output?**
A: Sì, modifica la variabile `OUTPUT_DIR` negli script.

**D: Perché servono xelatex e kdialog?**
A: xelatex genera PDF di qualità; kdialog fornisce la GUI.

------

## File Desktop per Avvio Rapido

Copia il launcher:

bash

```bash
cp extras/export-markdown.desktop ~/.local/share/applications/
chmod +x ~/.local/share/applications/export-markdown.desktop
```

------

## Strumenti opzionali

- **generate_changelog.sh** – genera automaticamente `CHANGELOG.md` dai commit Git.

  bash

  ```bash
  ./generate_changelog.sh
  ```
  
  

------

## AppImage pronta all’uso

Scarica `Markdown-Export-x86_64.AppImage` dall’ultima release:
https://github.com/alemazzi/esportazione-md/releases

---

### Template inclusi

Oltre agli script, la repository include **template personalizzati** per i vari formati, già posizionati nelle cartelle:

templates/pdf/       → editor-a4.tex, editor-a5.tex, editor-letter.tex
templates/odt/       → editor-a4.odt, editor-a5.odt
templates/docx/      → editor-a4.docx, editor-a5.docx
templates/epub/      → editor.css

------

## Compatibilità

- **Linux 64 bit** (testato su Nobara, Fedora, Ubuntu).
- Richiede `pandoc`, `xelatex`, `kdialog`/`zenity`.
- Su Windows/macOS usa WSL o ambienti simili.

------

## Licenza

GPL-3.0

------

## Contatti

Per domande o suggerimenti apri un issue su GitHub o scrivi all’autore.