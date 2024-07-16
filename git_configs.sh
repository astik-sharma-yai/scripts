#!/bin/bash

cat > ~/.gitconfig <<EOL
[user]
	name = Astik Sharma
	email = astik-sharma@Astik-Sharma.local

[alias]
	fclone = "!sudo rm -rf $1 ; git clone git@github.com:yellowdotai/$1.git &&:"
	ac = "!git checkout -- package-lock.json && git commit -am"
    comp = "!git checkout $1 ; git pull origin $1 &&: ; git merge --no-edit $2 &&: ; git push origin $1 &&: ; git checkout $2 &&:"
    d-comp = "!git branch -D $1; git fetch origin $1 && : ; git checkout $1 && : ; git merge --no-edit $2 &&: ; git push origin $1 &&: ; git checkout $2 &&:"
    d-comp-p = "!git branch -D $1; git fetch origin $1 && : ; git checkout $1 && : ; git merge --no-edit $2 &&: ; git push origin $1 &&: ; git checkout $2 &&:; git push origin $2 &&:"
    master = pull origin master
    main = pull origin main
    fp = push --force-with-lease origin
    fech = "!git fetch origin $1 && git checkout $1 && : "
    dfech = "!git branch -D $1; git fetch origin $1 && : ; git checkout $1 && : "
    staash = "!git add . && git stash --all"
    npm-install = "!npm install && git checkout -- package-lock.json"
    npm-i = "!npm install $1 $2 $3 $4 $5 && git checkout -- package-lock.json &&: &&: &&: &&: &&:"

[maintenance]
    repo = /Users/astik-sharma/yellow/spectrum
    repo = /Users/astik-sharma/yellow/web-app
    repo = /Users/astik-sharma/yellow/engage-web
    repo = /Users/astik-sharma/yellow/insights-web
	repo = /Users/astik-sharma/yellow/insights-service
	repo = /Users/astik-sharma/yellow/data-warehouse-service
	repo = /Users/astik-sharma/yellow/app
	repo = /Users/astik-sharma/yellow/admin-backend
	repo = /Users/astik-sharma/yellow/admin-portal-app
EOL


echo "Git config updated successfully!"