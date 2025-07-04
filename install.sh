#!/bin/sh

set -e

SCRIPT_DIR="$(cd $(dirname "$BASH_SOURCE[0]") && pwd)"
DEST_ROOT="$HOME"

for path in $(cat $SCRIPT_DIR/MANIFEST); do
  target="$SCRIPT_DIR/$path"
  destination="$DEST_ROOT/$path"

  mkdir -p "$(dirname "$destination")"

  if [ -L "$destination" ]; then
	echo "WARNING: $destination already linked. Skipping..."
	continue
  fi

  if [ -e "$destination" ]; then
   echo "ERROR: $destination is an existing file, not a symlink."
   exit 1
  fi
  
  ln -s "$target" "$destination" 
  echo "SUCCESS: $target -> $destination"
done

