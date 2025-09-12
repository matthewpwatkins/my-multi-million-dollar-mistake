#!/bin/bash

# Build script for Pandoc exports
# Run from the project root directory

cd book

# Auto-discover chapters in order
CHAPTERS=$(ls chapters/*.md | sort)

echo "Building EPUB..."
pandoc --metadata-file=_metadata.yml $CHAPTERS -o ../output/book.epub

echo "Building DOCX (for Google Docs import)..."
pandoc --metadata-file=_metadata.yml $CHAPTERS -o ../output/book.docx

echo "Building PDF..."
pandoc --metadata-file=_metadata.yml $CHAPTERS -o ../output/book.pdf

echo "Building HTML (single page)..."
pandoc --metadata-file=_metadata.yml $CHAPTERS -s --toc -o ../output/book.html

echo "All formats built successfully in output/ directory"