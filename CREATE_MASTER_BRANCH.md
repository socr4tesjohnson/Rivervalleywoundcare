# How to Create a Master Branch

This document provides instructions for creating a master branch in this repository.

## Current State

The repository currently has the following branches:
- `claude/wound-care-website-011CUwa5dGgoadywHvPokMGP` (current default branch)
- `claude/wound-care-website-faq-011CUwaToxja1awiAZyoa5wP`
- `copilot/create-master-branch`

Currently, there is **no master branch**.

## Why This Matters

Having a `master` (or `main`) branch is a GitHub convention that:
- Serves as the primary/default branch for the repository
- Is where stable, production-ready code lives
- Makes it easier for contributors to know which branch to fork from

## Steps to Create Master Branch

### Option 1: Using GitHub Web Interface (Easiest)

1. Go to your repository on GitHub: https://github.com/socr4tesjohnson/Rivervalleywoundcare
2. Click on the branch dropdown (currently showing your default branch)
3. Type "master" in the text field
4. Click "Create branch: master from [current-branch]"
5. Go to Settings > Branches
6. Change the default branch to "master"
7. Optionally, delete the old feature branches if no longer needed

### Option 2: Using Git Commands (For Repository Owner)

```bash
# Clone the repository if you haven't already
git clone https://github.com/socr4tesjohnson/Rivervalleywoundcare.git
cd Rivervalleywoundcare

# Fetch all branches
git fetch --all

# Create master branch from the main content branch
git checkout claude/wound-care-website-011CUwa5dGgoadywHvPokMGP
git checkout -b master

# Push the master branch to remote
git push -u origin master

# Now go to GitHub Settings > Branches to set master as default
```

### Option 3: Renaming Existing Branch

If you want to rename the existing default branch to master:

```bash
# Checkout the branch you want to rename
git checkout claude/wound-care-website-011CUwa5dGgoadywHvPokMGP

# Rename it to master
git branch -m master

# Push the renamed branch and set upstream
git push -u origin master

# Delete the old branch name from remote
git push origin --delete claude/wound-care-website-011CUwa5dGgoadywHvPokMGP

# Update default branch in GitHub Settings > Branches
```

## After Creating Master Branch

Once the master branch is created and set as default:

1. Update any CI/CD workflows to reference the master branch
2. Update documentation that references branch names
3. Inform collaborators about the new default branch
4. Consider protecting the master branch (Settings > Branches > Branch protection rules)

## Recommended Branch Protection Rules

For the master branch, consider enabling:
- ✅ Require pull request reviews before merging
- ✅ Require status checks to pass before merging
- ✅ Require branches to be up to date before merging
- ✅ Include administrators (optional but recommended)

## Note

This document was created as part of issue resolution. The automated process cannot directly create and push new branches due to security constraints. Repository administrators must follow the steps above to create the master branch.
