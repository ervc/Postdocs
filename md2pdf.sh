#!/bin/zsh
# Usage: ./md2pdf.sh filename.md
# Converts filename.md to filename.pdf using pandoc

if [ "$#" -ne 1 ]; then
  echo "Usage: $0 filename.md"
  exit 1
fi

input_file="$1"
output_file="${input_file%.md}.pdf"

if [[ ! -f "$input_file" ]]; then
  echo "Error: File '$input_file' not found."
  exit 1
fi

pandoc "$input_file" --template=template.tex -o "$output_file"

if [[ $? -eq 0 ]]; then
  echo "Successfully converted $input_file to $output_file"
else
  echo "Conversion failed."
  exit 1
fi
