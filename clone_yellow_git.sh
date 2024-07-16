#!/bin/bash

# gpg_key_id="KEY_ID"
base_dir="$HOME/yellow"

#This script clones and updates all the repositories mentioned in the clone folders

clone_folders=(
    "insights-web"
    "engage-web"
    "web-app"
    "vault"
    "channels-web"
    "insights-service"
    "app"
    "admin-backend"
    "admin-portal-app"
    "export-service"
    "sso"
    "hawk-eye"
    "spectrum"
    "data-service"
    "data-warehouse-service"
    "production-config"
    "aks"
    "aks-staging"
    "db-migrations"
)

# Check if the base directory exists
if [ ! -d "$base_dir" ]; then
    # Create the base directory if it doesn't exist
    mkdir -p "$base_dir"
fi


for dir in $(ls -d -1 "$base_dir"/*/); do
    dir_name=$(basename "$dir")

    if [[ " ${clone_folders[*]} " == *" $dir_name "* ]]; then
        echo "Re-cloning $dir_name..."
        rm -rf "$dir"
        git clone "git@github.com:yellowdotai/$dir_name.git" "$dir"
        # cd "$dir"
        # git config user.signingkey "$gpg_key_id"
        # git config commit.gpgsign true
        # cd $base_dir
    else
        if [[ -d "$dir/.git" ]]; then
            cd "$dir"
            git remote set-url origin "git@github.com:yellowdotai/$dir_name.git"
            # git config user.signingkey "$gpg_key_id"
            # git config commit.gpgsign true
            cd "$base_dir"
            echo "Updated remote for $dir_name"
        else
            echo "Skipping $dir_name, unsure of contents"
        fi
    fi
done

# Loop through each repository in the array
for repo in "${clone_folders[@]}"; do
    # Create the full path for the cloned repository
    clone_path="$base_dir/$repo"

    if [ ! -d "$clone_path" ]; then
        echo "Cloning $repo..."
        # Clone the repository using git clone
        git clone "git@github.com:yellowdotai/$repo.git" "$clone_path"
        # cd "$repo"
        # git config user.signingkey "$gpg_key_id"
        # git config commit.gpgsign true
        # cd $base_dir


        # Print a success message
        echo "Cloned repository: $repo"
    fi
done

echo "All repositories cloned successfully!"
