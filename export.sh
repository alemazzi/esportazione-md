#!/bin/bash

OUTPUT_DIR="$HOME/Esportazioni"
TEMPLATES_DIR="$HOME/scrittura-pandoc/templates"
mkdir -p "$OUTPUT_DIR"

export_single() {
  local file="$1"
  local format="$2"
  local paper_size="$3"
  shift 3
  local extra_params=("$@")

  format="${format//\"/}"

  if [ ! -f "$file" ]; then
    echo "❌ File non trovato: $file" >&2
    return 1
  fi

  local basename=$(basename "$file" .md)
  local extension="$format"
  [ "$format" = "html" ] && extension="html"
  local output_file="${OUTPUT_DIR}/${basename}-${paper_size}-$(date +%Y-%m-%d).${extension}"

  echo "🚀 Sto esportando in: $output_file"

  # Gestione numerazione automatica
  local numbering="--variable=numbersections:false"  # Default: NO numerazione
  if [[ " ${extra_params[@]} " =~ " --number-sections " ]]; then
      numbering="--number-sections"
  fi

  case "$format" in
    pdf)
      pandoc "$file" -o "$output_file" \
        --template="${TEMPLATES_DIR}/pdf/editor-${paper_size}.tex" \
        --pdf-engine=xelatex \
        $numbering \
        "${extra_params[@]}"
      ;;
    epub)
      local css_file="${TEMPLATES_DIR}/epub/editor.css"
      [ ! -f "$css_file" ] && echo "body { font-family: Georgia, serif; }" > "$css_file"
      pandoc "$file" -o "$output_file" \
        --css="$css_file" \
        --toc \
        --metadata title="$basename" \
        "${extra_params[@]}"
      ;;
    docx|odt)
      pandoc "$file" -o "$output_file" \
        --reference-doc="${TEMPLATES_DIR}/${format}/editor-${paper_size}.${format}" \
        "${extra_params[@]}"
      ;;
    html)
      pandoc "$file" -o "$output_file" \
        --standalone \
        $numbering \
        "${extra_params[@]}"
      ;;
    *)
      echo "❌ Formato non supportato: $format" >&2
      return 1
      ;;
  esac

  if [ -f "$output_file" ]; then
    echo "✅ Esportato: $output_file"
  else
    echo "❌ Errore esportazione: $file" >&2
    return 1
  fi
}

export_merged() {
  local format="$1"
  local paper_size="$2"
  shift 2
  local args=("$@")

  format="${format//\"/}"

  local extra_params=()
  local files=()

  for arg in "${args[@]}"; do
    if [[ "$arg" == --* ]]; then
      extra_params+=("$arg")
    else
      files+=("$arg")
    fi
  done

  # Gestione numerazione automatica
  local numbering="--variable=numbersections:false"  # Default: NO numerazione
  if [[ " ${extra_params[@]} " =~ " --number-sections " ]]; then
      numbering="--number-sections"
  fi

  local temp_file=$(mktemp)

  for file in "${files[@]}"; do
    if [ ! -f "$file" ]; then
      echo "❌ File non trovato: $file" >&2
      rm -f "$temp_file"
      return 1
    fi
    echo -e "\n\n" >> "$temp_file"
    cat "$file" >> "$temp_file"
  done

  local extension="$format"
  [ "$format" = "html" ] && extension="html"
  local output_file="${OUTPUT_DIR}/manoscritto-unito-${paper_size}-$(date +%Y-%m-%d).${extension}"

  echo "🚀 Sto esportando unito in: $output_file"

  case "$format" in
    pdf)
      pandoc "$temp_file" -o "$output_file" \
        --template="${TEMPLATES_DIR}/pdf/editor-${paper_size}.tex" \
        --pdf-engine=xelatex \
        --variable=pagenumbering:true \
        --variable=classoption:openany \
        $numbering \
        "${extra_params[@]}"
      ;;
    epub)
      pandoc "$temp_file" -o "$output_file" \
        --css="${TEMPLATES_DIR}/epub/editor.css" \
        --toc \
        --metadata title="Manoscritto Unito" \
        "${extra_params[@]}"
      ;;
    docx|odt)
      pandoc "$temp_file" -o "$output_file" \
        --reference-doc="${TEMPLATES_DIR}/${format}/editor-${paper_size}.${format}" \
        "${extra_params[@]}"
      ;;
    html)
      pandoc "$temp_file" -o "$output_file" \
        --standalone \
        $numbering \
        "${extra_params[@]}"
      ;;
    *)
      echo "❌ Formato non supportato: $format" >&2
      rm -f "$temp_file"
      return 1
      ;;
  esac

  rm -f "$temp_file"

  if [ -f "$output_file" ]; then
    echo "✅ File unito esportato: $output_file"
  else
    echo "❌ Errore esportazione file unito" >&2
    return 1
  fi
}

# Main
if [ "$#" -lt 3 ]; then
  echo "Utilizzo:"
  echo " Esportazione singola:"
  echo " $0 [a4|a5|letter] [pdf|docx|odt|epub|html] file.md [--number-sections] [opzioni-extra]"
  echo " Esportazione multipla:"
  echo " $0 [a4|a5|letter] [pdf|docx|odt|epub|html] file1.md file2.md... [--number-sections] [opzioni-extra]"
  echo " Unione file:"
  echo " $0 [a4|a5|letter] [pdf|docx|odt|epub|html] --merge file1.md file2.md... [--number-sections] [opzioni-extra]"
  echo ""
  echo "Opzioni:"
  echo "  --number-sections   Abilita numerazione automatica capitoli (default: disattivata)"
  exit 1
fi

paper_size="$1"
format="$2"
shift 2

# Verifica la presenza del flag --merge come primo argomento rimanente
if [[ "$1" == "--merge" ]]; then
  shift # Rimuove --merge dalla lista degli argomenti
  # Chiama la funzione di unione con i restanti argomenti (file e opzioni extra)
  export_merged "$format" "$paper_size" "$@"
else
  # Logica per l'esportazione singola o multipla
  args=()
  extra_params=()

  for arg in "$@"; do
    if [[ "$arg" == --* ]]; then
      extra_params+=("$arg")
    else
      args+=("$arg")
    fi
  done

  for file in "${args[@]}"; do
    export_single "$file" "$format" "$paper_size" "${extra_params[@]}"
  done
fi
