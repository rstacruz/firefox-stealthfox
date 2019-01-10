#!/usr/bin/env bash

for fn in \
  ${HOME}/.mozilla/firefox/*.default \
  ${HOME}/Library/Application\ Support/Firefox/Profiles/*.default \
  ${HOME}/Library/Mozilla/Firefox/Profiles/*.default ; do
  if [[ "$fn" =~ "*" ]]; then continue; fi
  mkdir -p "$fn/chrome"

  fullpath="$fn/chrome/userChrome.css"
  if [[ -e "$fullpath" ]]; then
    echo ""
    echo " !  Failed to install the Firefox theme."
    echo "    $fullpath exists; you may need to delete it first."
    echo ""
    exit 1
  else
    cp userChrome.css "$fullpath"
    echo ""
    echo "  Installed to '$fullpath'."
    echo "  Restart Firefox!"
    echo ""
  fi
done

