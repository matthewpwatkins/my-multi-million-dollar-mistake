#!/bin/bash

# Build script for Quarto exports
# Run from the project root directory

cd book

echo "Building all Quarto formats..."
quarto render

echo "Moving outputs to output directory..."
mkdir -p ../output
cp -r _book/* ../output/

echo "Quarto formats built successfully:"
echo "- HTML website in output/"
echo "- PDF in output/"
echo "- EPUB in output/"