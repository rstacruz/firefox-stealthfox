#!/usr/bin/env bash
SYMLINK=

while [[ "$1" =~ ^- && ! "$1" == "--" ]]; do case $1 in
  -h | --help)
    echo "Usage: $0 [--symlink]"
    exit
    ;;
  -s | --symlink | --link ) SYMLINK=1 ;;
esac; shift; done

for fn in \
  "$HOME"/.mozilla/firefox/*.default \
  "$HOME"/Library/Application\ Support/Firefox/Profiles/*.default \
  "$HOME"/Library/Mozilla/Firefox/Profiles/*.default ; do
  # shellcheck disable=SC2076
  if [[ "$fn" =~ "\*" ]]; then continue; fi
  mkdir -p "$fn/chrome"

  fullpath="$fn/chrome/userChrome.css"

  echo ""
  echo "$fullpath:"

  # Add -f/--force to delete it before writing
  if [[ -n "$FORCE" ]]; then
    rm -f "$fullpath"
  fi

  if [[ -e "$fullpath" ]] || [[ -h "$fullpath" ]]; then
    echo -ne " ! This file exists. Replace it? [Yn] "
    read -r choice
    if [[ "$choice" != "n" ]]; then
      rm -f "$fullpath"
    else
      exit 1
    fi
  fi

  if [[ -n "$SYMLINK" ]]; then
    ln -nfs userChrome.css "$fullpath"
    echo "   Symlinked. Restart Firefox to apply!"
  else
    cp userChrome.css "$fullpath"
    echo "   Copied. Restart Firefox to apply!"
  fi

  echo ""
done

