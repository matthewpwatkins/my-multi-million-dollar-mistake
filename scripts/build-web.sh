#!/bin/bash

# Build script for web deployment
# Creates separate pages for each chapter with navigation

cd book

# Clean and create output directories
rm -rf ../output/web
mkdir -p ../output/web
mkdir -p ../output/web/images
mkdir -p ../output/web/chapters

# Copy images
cp images/* ../output/web/images/

# Create CSS file
cat > ../output/web/style.css << 'EOF'
:root {
    --primary-color: #2c3e50;
    --secondary-color: #3498db;
    --text-color: #2c3e50;
    --background-color: #ffffff;
    --border-color: #ecf0f1;
    --code-background: #f8f9fa;
}

* {
    box-sizing: border-box;
}

body {
    font-family: -apple-system, BlinkMacSystemFont, 'Segoe UI', 'Roboto', 'Oxygen', 'Ubuntu', 'Cantarell', sans-serif;
    line-height: 1.6;
    color: var(--text-color);
    background-color: var(--background-color);
    margin: 0;
    padding: 0;
    font-size: 18px;
}

.container {
    max-width: 800px;
    margin: 0 auto;
    padding: 20px;
    min-height: 100vh;
    display: flex;
    flex-direction: column;
}

.content {
    flex: 1;
    margin-bottom: 40px;
}

h1, h2, h3, h4, h5, h6 {
    color: var(--primary-color);
    font-weight: 700;
    margin-top: 2em;
    margin-bottom: 1em;
    line-height: 1.3;
}

h1 {
    font-size: 2.5em;
    border-bottom: 3px solid var(--secondary-color);
    padding-bottom: 0.3em;
    margin-top: 0;
}

h2 {
    font-size: 2em;
    border-bottom: 2px solid var(--border-color);
    padding-bottom: 0.2em;
}

h3 {
    font-size: 1.5em;
}

p {
    margin-bottom: 1.5em;
    text-align: justify;
}

img {
    max-width: 100%;
    height: auto;
    display: block;
    margin: 2em auto;
    border-radius: 8px;
    box-shadow: 0 4px 8px rgba(0,0,0,0.1);
}

table {
    width: 100%;
    border-collapse: collapse;
    margin: 2em 0;
    font-size: 0.9em;
}

th, td {
    border: 1px solid var(--border-color);
    padding: 12px;
    text-align: left;
}

th {
    background-color: var(--code-background);
    font-weight: 600;
    color: var(--primary-color);
}

tr:nth-child(even) {
    background-color: #fafafa;
}

code {
    background-color: var(--code-background);
    padding: 2px 6px;
    border-radius: 4px;
    font-family: 'SF Mono', Monaco, 'Cascadia Code', 'Roboto Mono', Consolas, 'Courier New', monospace;
    font-size: 0.9em;
}

pre {
    background-color: var(--code-background);
    padding: 1.5em;
    border-radius: 8px;
    overflow-x: auto;
    border-left: 4px solid var(--secondary-color);
}

blockquote {
    border-left: 4px solid var(--secondary-color);
    padding-left: 1.5em;
    margin: 1.5em 0;
    font-style: italic;
    color: #555;
}

.navigation {
    background-color: var(--code-background);
    padding: 20px;
    border-radius: 8px;
    margin-bottom: 30px;
    border: 1px solid var(--border-color);
}

.nav-links {
    display: flex;
    justify-content: space-between;
    align-items: center;
    gap: 20px;
}

.nav-link {
    color: var(--secondary-color);
    text-decoration: none;
    padding: 10px 20px;
    border-radius: 6px;
    transition: all 0.3s ease;
    font-weight: 500;
}

.nav-link:hover {
    background-color: var(--secondary-color);
    color: white;
    text-decoration: none;
}

.nav-link.disabled {
    color: #ccc;
    cursor: not-allowed;
}

.nav-link.disabled:hover {
    background-color: transparent;
    color: #ccc;
}

.home-link {
    color: var(--primary-color);
    font-weight: 600;
}

.chapter-list {
    list-style: none;
    padding: 0;
}

.chapter-list li {
    margin-bottom: 15px;
}

.chapter-list a {
    display: block;
    padding: 15px 20px;
    background-color: var(--code-background);
    color: var(--primary-color);
    text-decoration: none;
    border-radius: 8px;
    border: 1px solid var(--border-color);
    transition: all 0.3s ease;
    font-weight: 500;
}

.chapter-list a:hover {
    background-color: var(--secondary-color);
    color: white;
    transform: translateY(-2px);
    box-shadow: 0 4px 12px rgba(52, 152, 219, 0.3);
}

.footer {
    margin-top: auto;
    padding-top: 40px;
    border-top: 1px solid var(--border-color);
    text-align: center;
    color: #777;
    font-size: 0.9em;
}

@media (max-width: 600px) {
    .container {
        padding: 15px;
    }
    
    body {
        font-size: 16px;
    }
    
    h1 {
        font-size: 2em;
    }
    
    h2 {
        font-size: 1.6em;
    }
    
    .nav-links {
        flex-direction: column;
        gap: 10px;
    }
    
    .nav-link {
        text-align: center;
        width: 100%;
    }
}
EOF

# Function to generate navigation for a chapter
generate_navigation() {
    local current_chapter=$1
    local prev_link=$2
    local next_link=$3
    local prev_title=$4
    local next_title=$5
    
    echo '<div class="navigation">'
    echo '  <div class="nav-links">'
    
    if [ "$prev_link" != "" ]; then
        echo "    <a href=\"$prev_link\" class=\"nav-link\">← $prev_title</a>"
    else
        echo "    <span class=\"nav-link disabled\">← Previous</span>"
    fi
    
    echo '    <a href="../index.html" class="nav-link home-link">📚 Table of Contents</a>'
    
    if [ "$next_link" != "" ]; then
        echo "    <a href=\"$next_link\" class=\"nav-link\">$next_title →</a>"
    else
        echo "    <span class=\"nav-link disabled\">Next →</span>"
    fi
    
    echo '  </div>'
    echo '</div>'
}

# Chapter information
chapters=(
    "00-title-and-contents.md:Title & Contents:index"
    "01-why-im-writing-this.md:Why I'm Writing This:chapter1"
    "02-eighth-wonder-of-the-world.md:The Eighth Wonder of the World:chapter2"
    "03-millionaire-of-time.md:Millionaire of Time:chapter3"
    "04-financial-success-plan.md:Your Financial Success Plan:chapter4"
    "05-how-to-get-started.md:How to Get Started:chapter5"
)

# Build individual chapters
for i in "${!chapters[@]}"; do
    IFS=':' read -r filename title slug <<< "${chapters[$i]}"
    
    # Determine previous and next chapters
    prev_link=""
    next_link=""
    prev_title=""
    next_title=""
    
    if [ $i -gt 0 ]; then
        prev_i=$((i-1))
        IFS=':' read -r prev_file prev_t prev_s <<< "${chapters[$prev_i]}"
        prev_link="${prev_s}.html"
        prev_title="$prev_t"
    fi
    
    if [ $i -lt $((${#chapters[@]}-1)) ]; then
        next_i=$((i+1))
        IFS=':' read -r next_file next_t next_s <<< "${chapters[$next_i]}"
        next_link="${next_s}.html"
        next_title="$next_t"
    fi
    
    echo "Building chapter: $title"
    
    # Build the chapter HTML
    {
        echo '<!DOCTYPE html>'
        echo '<html lang="en">'
        echo '<head>'
        echo '    <meta charset="UTF-8">'
        echo '    <meta name="viewport" content="width=device-width, initial-scale=1.0">'
        echo "    <title>$title - My Multi-Million Dollar Mistake</title>"
        echo '    <link rel="stylesheet" href="../style.css">'
        echo '</head>'
        echo '<body>'
        echo '    <div class="container">'
        echo '        <div class="content">'
        
        # Add navigation
        generate_navigation "$i" "$prev_link" "$next_link" "$prev_title" "$next_title"
        
        # Convert markdown to HTML, fixing image paths and removing anchor tags
        pandoc --metadata-file=_metadata.yml "chapters/$filename" \
            --to html \
            --no-highlight \
            | sed 's|src="images/|src="../images/|g' \
            | sed 's| {#[^}]*}||g' \
            | sed 's|id="[^"]*:-[^"]*"|id=""|g' \
            | sed 's|id="[^"]*\?[^"]*"|id=""|g' \
            | sed 's|id="[^"]*([^"]*)[^"]*"|id=""|g'
        
        echo '        </div>'
        echo '        <div class="footer">'
        echo '            <p>&copy; 2025 My Multi-Million Dollar Mistake</p>'
        echo '        </div>'
        echo '    </div>'
        echo '</body>'
        echo '</html>'
    } > "../output/web/chapters/$slug.html"
done

# Create main index page
echo "Building index page..."
{
    echo '<!DOCTYPE html>'
    echo '<html lang="en">'
    echo '<head>'
    echo '    <meta charset="UTF-8">'
    echo '    <meta name="viewport" content="width=device-width, initial-scale=1.0">'
    echo '    <title>My Multi-Million Dollar Mistake</title>'
    echo '    <link rel="stylesheet" href="style.css">'
    echo '</head>'
    echo '<body>'
    echo '    <div class="container">'
    echo '        <div class="content">'
    echo '            <h1>My Multi-Million Dollar Mistake</h1>'
    echo '            <h2>What I Wish I Knew About Finances as a Young Adult</h2>'
    echo '            <p>Welcome to this guide on financial literacy and wealth building. Navigate through the chapters below to learn about compound interest, investment strategies, and how to avoid the costly mistakes that can derail your financial future.</p>'
    echo '            <ul class="chapter-list">'
    
    for chapter in "${chapters[@]}"; do
        IFS=':' read -r filename title slug <<< "$chapter"
        echo "                <li><a href=\"chapters/$slug.html\">$title</a></li>"
    done
    
    echo '            </ul>'
    echo '        </div>'
    echo '        <div class="footer">'
    echo '            <p>&copy; 2025 My Multi-Million Dollar Mistake</p>'
    echo '        </div>'
    echo '    </div>'
    echo '</body>'
    echo '</html>'
} > "../output/web/index.html"

# Also build the legacy formats
echo "Building legacy formats..."
CHAPTERS=$(ls chapters/*.md | sort)

echo "Building EPUB..."
pandoc --metadata-file=_metadata.yml $CHAPTERS -o ../output/book.epub

echo "Building DOCX (for Google Docs import)..."
pandoc --metadata-file=_metadata.yml $CHAPTERS -o ../output/book.docx

echo "Building HTML (single page)..."
pandoc --metadata-file=_metadata.yml $CHAPTERS -s --toc -o ../output/book.html

echo "Web version built successfully in output/web/ directory"
echo "Legacy formats built successfully in output/ directory"