#!/bin/bash
#
# ThinkFirst Automated Deployment Script
# Deploys ThinkFirst to the target directory on Linux/macOS
#
# Usage:
#   bash deploy.sh                           # Deploy to current directory
#   TARGET_DIR=/path/to/folder bash deploy.sh  # Deploy to specific directory
#

set -e

# Colors for output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m' # No Color

# Configuration
TARGET_DIR="${TARGET_DIR:-.}"
REPO="saurabhgayali/ThinkFirst"
BRANCH="main"
TEMP_DIR=$(mktemp -d)

# Function to print colored output
print_status() {
    echo -e "${BLUE}[ThinkFirst]${NC} $1"
}

print_success() {
    echo -e "${GREEN}✓${NC} $1"
}

print_error() {
    echo -e "${RED}✗${NC} $1"
}

print_warning() {
    echo -e "${YELLOW}!${NC} $1"
}

# Cleanup on exit
cleanup() {
    rm -rf "$TEMP_DIR"
}
trap cleanup EXIT

print_status "Starting ThinkFirst deployment..."
print_status "Target directory: $TARGET_DIR"

# Create target directory if it doesn't exist
mkdir -p "$TARGET_DIR"

# Verify target directory is writable
if [ ! -w "$TARGET_DIR" ]; then
    print_error "Target directory is not writable: $TARGET_DIR"
    exit 1
fi

# Download the repository archive
print_status "Downloading ThinkFirst from GitHub..."
ARCHIVE_URL="https://github.com/${REPO}/archive/refs/heads/${BRANCH}.zip"

if ! command -v curl &> /dev/null; then
    print_error "curl is required but not installed"
    exit 1
fi

if ! curl -fsSL "$ARCHIVE_URL" -o "$TEMP_DIR/archive.zip"; then
    print_error "Failed to download archive from GitHub"
    exit 1
fi

print_success "Archive downloaded"

# Extract the archive
print_status "Extracting archive..."
if ! command -v unzip &> /dev/null; then
    print_warning "unzip is not installed, attempting to use tar instead..."
    if ! command -v tar &> /dev/null; then
        print_error "Neither unzip nor tar is available"
        exit 1
    fi
    cd "$TEMP_DIR"
    tar -xzf "$TEMP_DIR/archive.zip" 2>/dev/null || {
        print_error "Failed to extract archive using tar"
        exit 1
    }
else
    if ! unzip -q "$TEMP_DIR/archive.zip" -d "$TEMP_DIR"; then
        print_error "Failed to extract archive"
        exit 1
    fi
fi

print_success "Archive extracted"

# Find the extracted directory (it will be named ThinkFirst-main or similar)
EXTRACTED_DIR=$(find "$TEMP_DIR" -maxdepth 1 -type d -name "ThinkFirst-*" | head -1)
if [ -z "$EXTRACTED_DIR" ]; then
    print_error "Could not find extracted ThinkFirst directory"
    exit 1
fi

print_status "Copying files to target directory..."

# Define files and directories to copy
FILES_TO_COPY=("SKILL.md" "README.md" "CHANGELOG.md" "LICENSE" "rules" "examples" "tests")

for item in "${FILES_TO_COPY[@]}"; do
    SRC="$EXTRACTED_DIR/$item"
    DEST="$TARGET_DIR/$item"
    
    if [ ! -e "$SRC" ]; then
        print_warning "Source not found: $item"
        continue
    fi
    
    if [ -e "$DEST" ]; then
        print_warning "File/directory already exists, comparing: $item"
        
        # Compare files/directories
        if diff -r "$SRC" "$DEST" > /dev/null 2>&1; then
            print_status "No changes detected in: $item"
        else
            print_warning "Files differ for: $item. Keeping existing version."
            print_warning "To update, remove or backup the existing $item and rerun deploy.sh"
        fi
    else
        cp -r "$SRC" "$DEST"
        print_success "Copied: $item"
    fi
done

print_status "Verifying installation..."

# Verify essential files exist
ESSENTIAL_FILES=("SKILL.md" "README.md")
INSTALLATION_OK=true

for file in "${ESSENTIAL_FILES[@]}"; do
    if [ ! -f "$TARGET_DIR/$file" ]; then
        print_error "Essential file missing: $file"
        INSTALLATION_OK=false
    fi
done

# Verify rules directory exists and contains files
if [ ! -d "$TARGET_DIR/rules" ] || [ -z "$(ls -A "$TARGET_DIR/rules" 2>/dev/null)" ]; then
    print_error "Rules directory is missing or empty"
    INSTALLATION_OK=false
fi

if $INSTALLATION_OK; then
    print_success "ThinkFirst successfully deployed!"
    print_status "Location: $TARGET_DIR"
    print_status ""
    print_status "Next steps:"
    echo "  1. SKILL.md is ready to use as your AI system prompt"
    echo "  2. rules/ folder contains detailed behavioral documentation"
    echo "  3. examples/ folder contains usage examples"
    echo "  4. See README.md for complete documentation"
    exit 0
else
    print_error "Installation verification failed"
    exit 1
fi
