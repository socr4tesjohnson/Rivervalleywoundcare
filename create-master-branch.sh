#!/bin/bash

# Script to create and push a master branch for Rivervalleywoundcare repository
# This script should be run by the repository owner/administrator

set -e  # Exit on error

echo "==========================================="
echo "Master Branch Creation Script"
echo "==========================================="
echo ""

# Check if we're in a git repository
if [ ! -d .git ]; then
    echo "Error: Not in a git repository. Please run this script from the repository root."
    exit 1
fi

# Check current branch
CURRENT_BRANCH=$(git rev-parse --abbrev-ref HEAD)
echo "Current branch: $CURRENT_BRANCH"
echo ""

# Check if master branch already exists
if git show-ref --verify --quiet refs/heads/master; then
    echo "Master branch already exists locally."
    read -p "Do you want to recreate it? (y/N): " -n 1 -r
    echo ""
    if [[ ! $REPLY =~ ^[Yy]$ ]]; then
        echo "Aborting."
        exit 0
    fi
    git branch -D master
fi

# Check if master exists on remote
if git ls-remote --exit-code --heads origin master > /dev/null 2>&1; then
    echo "Master branch already exists on remote."
    read -p "Do you want to overwrite it? (y/N): " -n 1 -r
    echo ""
    if [[ ! $REPLY =~ ^[Yy]$ ]]; then
        echo "Aborting."
        exit 0
    fi
fi

echo "Select the source for the master branch:"
echo "1. Create from current branch ($CURRENT_BRANCH)"
echo "2. Create from claude/wound-care-website-011CUwa5dGgoadywHvPokMGP"
echo "3. Create from specific commit/branch (you will be prompted)"
read -p "Enter choice (1-3): " CHOICE

case $CHOICE in
    1)
        SOURCE=$CURRENT_BRANCH
        ;;
    2)
        SOURCE="claude/wound-care-website-011CUwa5dGgoadywHvPokMGP"
        ;;
    3)
        read -p "Enter commit SHA or branch name: " SOURCE
        ;;
    *)
        echo "Invalid choice. Aborting."
        exit 1
        ;;
esac

echo ""
echo "Creating master branch from: $SOURCE"

# Fetch all branches to make sure we have the latest
echo "Fetching latest changes..."
git fetch --all

# Create master branch
git checkout -b master $SOURCE

echo ""
echo "Master branch created locally!"
echo ""

# Ask if user wants to push
read -p "Push master branch to remote? (Y/n): " -n 1 -r
echo ""
if [[ $REPLY =~ ^[Nn]$ ]]; then
    echo "Master branch created locally but not pushed."
    echo "You can push it later with: git push -u origin master"
    exit 0
fi

# Push master branch
echo "Pushing master branch to remote..."
git push -u origin master

echo ""
echo "==========================================="
echo "✓ Master branch created and pushed successfully!"
echo "==========================================="
echo ""
echo "Next steps:"
echo "1. Go to: https://github.com/socr4tesjohnson/Rivervalleywoundcare/settings/branches"
echo "2. Change the default branch to 'master'"
echo "3. Consider setting up branch protection rules for master"
echo ""
echo "You may also want to clean up old feature branches."
