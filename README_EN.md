# Markdown Export – Bash Scripts

🇮🇹 [Italian version](README.md)

- [Description](#description)
- [Included Scripts](#included-scripts)
- [Requirements](#requirements)
- [Installation](#installation)
- [Folder Configuration](#folder-configuration)
- [Usage](#usage)
- [Quick Examples](#quick-examples)
- [FAQ](#faq)
- [Quick-Launch Desktop File](#quick-launch-desktop-file)
- [Optional Tools](#optional-tools)
- [Compatibility](#compatibility)
- [License](#license)
- [Contact](#contact)

## Description

This repository provides two Bash scripts to export Markdown (`.md`) files to **PDF, EPUB, DOCX, ODT** and **HTML**, with advanced options for batch processing and a wizard-style GUI.

## Included Scripts

| Script            | Purpose                                                      |
| ----------------- | ------------------------------------------------------------ |
| **export.sh**     | CLI tool for exporting one or many Markdown files to multiple formats, choosing paper size, alignment, hyphenation, and merging. |
| **export-gui.sh** | Graphical wizard (kdialog) to select export mode, output formats, paper size and target files. |

## Requirements

- **pandoc** (system-wide)  
- **xelatex** (TeX Live) for PDF  
- **kdialog** (or **zenity** on non-KDE desktops)  
- Custom templates in `$HOME/scrittura-pandoc/templates`

## Installation

### Ubuntu / Debian

```bash
sudo apt update
sudo apt install pandoc texlive-xetex kdialog


```

### AppImage (zero-install)

1. Download the latest release
   https://github.com/alemazzi/esportazione-md/releases

2. Make it executable and run

   bash

   复制

   ```bash
   chmod +x Markdown-Export-x86_64.AppImage
   ./Markdown-Export-x86_64.AppImage
   ```

   

## Folder Configuration

表格

复制

| Variable      | Default                            | Purpose          |
| :------------ | :--------------------------------- | :--------------- |
| TEMPLATES_DIR | `$HOME/scrittura-pandoc/templates` | Pandoc templates |
| OUTPUT_DIR    | `$HOME/Esportazioni`               | Generated files  |

Feel free to edit these paths inside the scripts.

## Usage

### Terminal

bash

复制

```bash
./export.sh a4 pdf file.md --variable=alignment:left
```

### GUI

bash

复制

```bash
./export-gui.sh
```

## Quick Examples

表格

复制

| Task               | Command                           |
| :----------------- | :-------------------------------- |
| Single PDF A4      | `./export.sh a4 pdf note.md`      |
| Multi-file EPUB    | `./export.sh a5 epub chap*.md`    |
| Merge all into PDF | `./export.sh a4 pdf --merge *.md` |

## FAQ

**Q: What if the template folder is missing?**
A: The script exits with an error. Create `$HOME/scrittura-pandoc/templates` and add the required files.

**Q: Can I change the output folder?**
A: Yes, edit the `OUTPUT_DIR` variable in the scripts.

**Q: Why xelatex for PDFs?**
A: xelatex provides superior font handling and layout quality compared to the default LaTeX engine.

## Quick-Launch Desktop File

Copy the ready-made launcher:

bash

复制

```bash
cp extras/export-markdown.desktop ~/.local/share/applications/
chmod +x ~/.local/share/applications/export-markdown.desktop
```

## Optional Tools

- **generate_changelog.sh** – auto-generate `CHANGELOG.md` from Git commits

  bash

  复制

  ```bash
  ./generate_changelog.sh
  ```

  ---
  
  ### Included Templates
  
  In addition to the scripts, this repository contains **custom templates** for different formats, located in the following folders:
  
  templates/pdf/       → editor-a4.tex, editor-a5.tex, editor-letter.tex
  templates/odt/       → editor-a4.odt, editor-a5.odt
  templates/docx/      → editor-a4.docx, editor-a5.docx
  templates/epub/      → editor.css

## Compatibility

- **Linux 64-bit** (tested on Nobara, Fedora, Ubuntu).
- AppImage requires `pandoc`, `xelatex`, and `kdialog`/`zenity`.
- For Windows/macOS see [WSL](https://learn.microsoft.com/windows/wsl/) or similar.

## License

GPL-3.0

## Contact

Open an issue on GitHub or email the author.