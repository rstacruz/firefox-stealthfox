#!usr/bin/env bash
for fn in \
  ${HOME}/.mozilla/firefox/*.default \
  ${HOME}/Library/Application\ Support/Firefox/Profiles/*.default \
  ${HOME}/Library/Mozilla/Firefox/Profiles/*.default ; do
  if [[ "$fn" =~ "*" ]]; then continue; fi
  mkdir -p "$fn/chrome"
  cp userChrome.css "$fn/chrome/userChrome.css"
  echo "Installed to '$fn/chrome/userChrome.css'."
done

