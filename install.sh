#!/bin/bash

# Prompt the user to enter their GitHub access token
echo "Insert GitHub Access Token:"
read -p "> " GITHUB_TOKEN

# Hardcoded repository URL and destination directory
REPO_URL="https://github.com/GiovanniBaccichet/dotfiles"
DEST_DIR="~/dotfiles"

# Create the destination directory if it does not exist
mkdir -p "$DEST_DIR"

# Clone the repository using the provided GitHub token
echo "Cloning repository..."
git clone https://$GITHUB_TOKEN@${REPO_URL#https://} "$DEST_DIR"

# Check if the clone was successful
if [ $? -eq 0 ]; then
    echo "Repository successfully cloned into $DEST_DIR."

    # Navigate into the repository directory
    cd "$DEST_DIR" || { echo "Failed to change directory to $DEST_DIR"; exit 1; }

    # Run stow . within the repository directory
    echo "Running 'stow .' in $DEST_DIR..."
    stow .

    # Check if stow was successful
    if [ $? -eq 0 ]; then
        echo "'stow .' executed successfully."
    else
        echo "Failed to execute 'stow .'."
    fi
else
    echo "Failed to clone the repository."
fi
