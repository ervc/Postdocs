#!/bin/zsh

# Usage: ./md2pdf.sh filename.md [references.bib]
# Converts filename.md to filename.pdf using pandoc, optionally linking citations from a .bib file

if [ "$#" -lt 1 ] || [ "$#" -gt 2 ]; then
  echo "Usage: $0 filename.md [references.bib]"
  exit 1
fi

input_file="$1"
output_file="${input_file%.md}.pdf"

if [[ ! -f "$input_file" ]]; then
  echo "Error: File '$input_file' not found."
  exit 1
fi

# If a .bib file is provided, check if it exists and add to pandoc command
if [ "$#" -eq 2 ]; then
  bib_file="$2"
  if [[ ! -f "$bib_file" ]]; then
    echo "Error: Bibliography file '$bib_file' not found."
    exit 1
  fi
  pandoc "$input_file" --template=template.tex --citeproc --bibliography="$bib_file" --metadata link-citations=true --csl=../nature.csl -o "$output_file"
else
  pandoc "$input_file" --template=template.tex -o "$output_file"
fi

if [[ $? -eq 0 ]]; then
  echo "Successfully converted $input_file to $output_file"
else
  echo "Conversion failed."
  exit 1
fi
