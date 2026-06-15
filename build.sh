#!/usr/bin/env bash
set -euo pipefail

SCRIPT="MusicRatingPrompter.applescript"
APP="Music Rating Prompter.app"

if [[ "$(uname)" != "Darwin" ]]; then
	echo "Error: This build must run on macOS." >&2
	exit 1
fi

if [[ ! -f "$SCRIPT" ]]; then
	echo "Error: $SCRIPT not found." >&2
	exit 1
fi

rm -rf "$APP"

# -s: stay-open applet (required for 'on idle' handlers)
# -o: output application bundle
osacompile -s -o "$APP" "$SCRIPT"

echo "Built $APP"
