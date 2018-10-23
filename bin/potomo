#!/bin/bash

read -p "Please input locale name['ru_RU']:" locale
locale=${locale:-ru_RU}
msgcat $locale.po | msgfmt -o $locale.mo -
echo "Your .mo file was (re)compiled."
echo ""
