#!/bin/bash

# sudo -s -H

ssh-add -D
rm -rf ~/.ssh/*

# -o = open ssh
# -a 100 = will run 100 tests to check if the produced key is prime or not (for better security)
# -C = comment
# -f = filepath where it will be saved
# -N = passphrase that should be associated with this generated 

# yes "y" | ssh-keygen -o -a 100 -t ed25519 -C "astik.sharma@yellow.ai" -f "$HOME/.ssh/id_ed25519" -N ""  (-f "$HOME/.ssh/id_ed25519" is not added since it will be by default)
yes "y" | ssh-keygen -o -a 100 -t ed25519 -C "astik.sharma@yellow.ai" -N "" 

cp "$HOME"/.ssh/id_ed25519.pub "$HOME"/.ssh/authorized_keys

echo "User's ssh keys home directory '$HOME'."

#Adding ssh keys to ssh-agent so that it remembers the configurations
eval "$(ssh-agent -s)"

if [[ ! -e ~/.ssh/config ]]; then
    touch ~/.ssh/config
fi

# Host SERVER_NAME
#     UseKeychain yes (not included here need additional setting and research to set keychains)
#     IdentitiesOnly yes
#     IdentityFile FILE_PATH  
cat > ~/.ssh/config <<EOL
Host github.com
  AddKeysToAgent yes
  User astik-sharma-yai
  PubKeyAuthentication yes
  IdentityFile ~/.ssh/id_ed25519
  IgnoreUnknown UseKeychain
EOL

cat ~/.ssh/config

ssh-add ~/.ssh/id_ed25519

echo "The key is added to the config file"