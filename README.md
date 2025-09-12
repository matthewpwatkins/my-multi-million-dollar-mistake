# My Multi-Million Dollar Mistake

A book about personal finance and the power of compound interest for young adults.

## Project Structure

```
├── book/                    # Main book content
│   ├── chapters/           # Book chapters (auto-discovered in order)
│   │   ├── 00-title-and-contents.md # Title page and table of contents
│   │   ├── 01-why-im-writing-this.md # Introduction chapter
│   │   ├── 02-eighth-wonder-of-the-world.md # Chapter 1: The eighth wonder of the world
│   │   ├── 03-millionaire-of-time.md # Wealth multiplier section
│   │   ├── 04-financial-success-plan.md # Chapter 2: Your Financial Success Plan
│   │   └── 05-how-to-get-started.md # Getting started resources
│   ├── images/             # Book images
│   ├── _quarto.yml         # Quarto configuration
│   └── _metadata.yml       # Pandoc metadata
├── scripts/                # Build scripts
│   ├── build-pandoc.sh     # Pandoc export script
│   └── build-quarto.sh     # Quarto export script
├── output/                 # Generated book files
└── reference/              # Original exported content
```

## First-Time Setup

Before you can build the book, you need to install the required tools:

### Option 1: Pandoc (Recommended)

**Ubuntu/Debian:**
```bash
sudo apt-get update
sudo apt-get install pandoc
```

**macOS:**
```bash
brew install pandoc
```

**Windows:**
Download and install from [pandoc.org](https://pandoc.org/installing.html)

### Option 2: Quarto (Alternative)

**All platforms:**
Download and install from [quarto.org](https://quarto.org/docs/get-started/)

### Verify Installation

```bash
# Check Pandoc version
pandoc --version

# Check Quarto version (if using Quarto)
quarto --version
```

## Writing Workflow

1. **Edit chapters**: Modify individual markdown files in the `book/chapters/` directory
2. **Add images**: Place images in `book/images/` and reference them as `![](images/filename.png)`
3. **Chapter order**: Chapters are auto-discovered by filename order (no manual list needed!)

## Export Formats

### Option 1: Pandoc (Recommended for maximum format support)

```bash
# Create output directory
mkdir -p output

# Build all formats
./scripts/build-pandoc.sh
```

**Outputs**:
- `output/book.epub` - EPUB format (priority #1)
- `output/book.docx` - Word document for Google Docs import (priority #2)
- `output/book.html` - Single-page HTML (priority #3)
- `output/book.pdf` - PDF format

### Option 2: Quarto (Alternative with integrated website)

```bash
# Build all formats including website
./scripts/build-quarto.sh
```

**Outputs**:
- `output/` - Multi-page HTML website
- `output/book.pdf` - PDF format
- `output/book.epub` - EPUB format

## Publishing Options

### Website Publishing
- **Quarto**: Automatically generates a navigable website
- **GitHub Pages**: Deploy the `output/` directory to GitHub Pages
- **Netlify/Vercel**: Connect to your repository for automatic builds

### E-book Distribution
- **EPUB**: Compatible with Apple Books, Google Play Books, Kobo
- **Kindle**: Convert EPUB to MOBI using [Kindle Previewer](https://kdp.amazon.com/en_US/help/topic/G202131170)

### Document Sharing
- **Google Docs**: Import the DOCX file to share with collaborators
- **PDF**: Universal format for sharing and printing

## Adding New Chapters

1. Create a new markdown file: `book/chapters/06-descriptive-chapter-name.md`
2. Add the chapter to `book/_quarto.yml` under `chapters:` (for Quarto only)
3. Run the build script to regenerate outputs

**Note**: Pandoc automatically discovers chapters in `book/chapters/` by filename order, so no manual file list is needed!

## Tips

- **Image optimization**: Compress images before adding to keep file sizes manageable
- **Cross-references**: Use heading IDs (`{#my-heading}`) for internal links
- **Footnotes**: Use `[^1]` syntax for footnotes
- **Tables**: Markdown tables are supported in both Pandoc and Quarto
- **Math**: Use LaTeX syntax for mathematical expressions

## Troubleshooting

- **Missing images**: Ensure image paths are relative to the markdown file location
- **Build errors**: Check that chapter files exist in `book/chapters/`
- **PDF issues**: Install LaTeX (e.g., TeX Live) for PDF generation
- **DOCX compatibility**: Test imports in Google Docs and adjust formatting as needed