# Markdown Export – Bash Scripts

## Description
This repository provides two Bash scripts to export Markdown (`.md`) files to **PDF, EPUB, DOCX, ODT** and **HTML**, with advanced options for batch processing and GUI-driven workflows.

## Included Scripts
| Script          | Purpose                                                      |
| --------------- | ------------------------------------------------------------ |
| `export.sh`     | Command-line tool to export one or many Markdown files. Supports paper size, alignment, hyphenation, and merging. |
| `export-gui.sh` | Graphical wizard based on `kdialog` for interactive export (select mode, formats, paper size, files). |

## Requirements
- **pandoc** (system-wide)
- **xelatex** (for PDF output; part of TeX Live)
- **kdialog** (for the GUI)
- Custom templates in `$HOME/scrittura-pandoc/templates`

## Installation – Ubuntu / Debian
```bash
sudo apt update
sudo apt install pandoc texlive-xetex kdialog
```

For other distros, install the equivalent packages.

## Folder Configuration



| Variable        | Default                            | Purpose          |
| :-------------- | :--------------------------------- | :--------------- |
| `TEMPLATES_DIR` | `$HOME/scrittura-pandoc/templates` | Pandoc templates |
| `OUTPUT_DIR`    | `$HOME/Esportazioni`               | Generated files  |

Edit the paths inside the scripts to match your system.

## Usage

### Terminal

bash



```bash
# Single file → PDF A4 left-aligned
./export.sh a4 pdf document.md --variable=alignment:left

# Multiple files → EPUB A5
./export.sh a5 epub chap1.md chap2.md

# Merge all files into one PDF
./export.sh a4 pdf --merge *.md
```

### GUI

bash



```bash
./export-gui.sh
```

## Examples



| Task      | Command                                 |
| :-------- | :-------------------------------------- |
| One PDF   | `./export.sh a4 pdf novel.md`           |
| EPUB book | `./export.sh a5 epub book/*.md --merge` |
| Wizard    | `./export-gui.sh`                       |

## FAQ

**Q: The template folder doesn’t exist—what happens?**
A: The script exits with an error. Create the folder or adjust the path.

**Q: Can I change the output folder?**
A: Yes—edit the `OUTPUT_DIR` variable in the script.

**Q: Why xelatex for PDF?**
A: It offers superior font support and layout quality compared to the default LaTeX engine.

## Quick-Launch Desktop File

Copy `extras/markdown-export.desktop` to `~/.local/share/applications/`, make it executable and update the `Exec=` path to point at your `export-gui.sh`.

bash



```bash
chmod +x ~/.local/share/applications/markdown-export.desktop
```

## Optional Tools

`generate_changelog.sh` – automatically builds `CHANGELOG.md` from Git commits.

bash



```bash
./generate_changelog.sh
```

## Compatibility

Developed and tested on **Linux** (Fedora, Ubuntu, Nobara).
Windows/macOS users can run the scripts inside WSL or similar environments.

## License

GPL-3.0

## Contacts

Open an issue on GitHub or email the author for questions or suggestions.