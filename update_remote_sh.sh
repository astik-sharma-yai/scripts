#!/bin/bash

base_dir="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
gpg_key_id="KEY_ID"

reclone_folders=(
    "cloud-controller"
    "istio"
    "aks"
    "backup"
    "vault"
    "allen-nlp"
    "autolabelv3"
    "ml-python"
    "tts-serve"
    "ym-transformers"
    "ytts_serve"
    "hacker-pro-single-tenant"
    "onprem-deployments"
    "onpremise-manifests"
    "q2-22-swarm-onprem"
    "terraform-sin"
    "asterisk-docker"
)

for dir in $(ls -d -1 "$base_dir"/*/); do
    dir_name=$(basename "$dir")

    if [[ " ${reclone_folders[*]} " == *" $dir_name "* ]]; then
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