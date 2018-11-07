#!/bin/bash
BASE_URL="https://raw.githubusercontent.com/github/gitignore/master"

if [ -z "$1" ];
  then
    echo -e "\\nGitignore Downloader"
    echo    "======================================="
    echo -e "Thanks to github/gitignore contributors\\n"
    echo    "Usage:"
    echo    "    gitignore <lang_name> to download a .gitignore file"
    echo -e "    specific to a language of your choice\\n"
    echo    "    Example: gitignore Python # downloads .gitignore"
    echo    "    for Python into a current directory"
  else
    echo "$1.gitignore"

    result=$(curl --url "$BASE_URL/$1.gitignore")

    if [ "$result" != "404: Not Found" ];
        then
            echo ".gitignore for your $1 project was downloaded successfully."
	    echo "$result" >> .gitignore
        else
            echo "[Error]: Can't find a .gitignore file for the $1 project."
    fi
fi
