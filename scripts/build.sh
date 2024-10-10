#!/bin/bash

# Get the directory of the script
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

# Function to move the codeblocks directory from blogs to public
move_codeblocks() {
  # Define the source and destination directories
  local source_dir="blogs/codeblocks"
  local dest_dir="public/codeblocks"

  # Create the destination directory if it doesn't exist
  mkdir -p "$dest_dir"

  # Move the entire codeblocks directory from blogs to public
  cp -r "$source_dir"/* "$dest_dir"

  echo "The codeblocks directory has been copied from blogs to public."
}

# Function to generate HTML files for all blogs
build_html() {
  echo "Generating HTML files for each blog..."
  
  BLOGS_DIR="$SCRIPT_DIR/../blogs/pages"
  PUBLIC_DIR="$SCRIPT_DIR/../public"

  # Iterate over all .md files in the blogs directory
  for md_file in "$BLOGS_DIR"/*.md; do
    filename=$(basename -- "$md_file")
    name="${filename%.*}"
    
    # Generate HTML for each markdown file
    pandoc --toc -s --css "reset.css" --css "index.css" \
      -i "$md_file" -o "$PUBLIC_DIR/$name.html" --template="$SCRIPT_DIR/../templates/blog.html"
    
    if [ $? -eq 0 ]; then
      echo "$PUBLIC_DIR/$name.html generated successfully."  
    else
      echo "Error: Failed to generate $PUBLIC_DIR/$name.html."
      exit 1
    fi
  done
  
  # Generate index.html with links to all blogs
  echo "Generating index.html from index.md..."
  pandoc --toc -s --css "reset.css" --css "index.css" \
    -i "$SCRIPT_DIR/../index.md" -o "$SCRIPT_DIR/../public/index.html" --template="$SCRIPT_DIR/../templates/index.html"
  
  if [ $? -eq 0 ]; then
    echo "public/index.html generated successfully."
  else
    echo "Error: Failed to generate public/index.html."
    exit 1
  fi
}

# Function to clean (remove all HTML files)
clean() {

  PUBLIC_DIR="$SCRIPT_DIR/../public"
  echo "Cleaning generated files..."
  for html_file in "$PUBLIC_DIR"/*.html; do
    rm -f "$html_file"  # Correctly reference the file without concatenating

    if [ $? -eq 0 ]; then
      echo "Removed: $html_file"
    else
      echo "Error: Failed to remove $html_file."
      exit 1
    fi
  done
  echo "All generated HTML files removed."
}

# Parse command-line arguments
if [ "$1" == "clean" ]; then
  clean
elif [ "$1" == "move_codeblocks" ]; then
  move_codeblocks
elif [ "$1" == "build_html" ]; then
  build_html
else
  move_codeblocks
  build_html
fi
