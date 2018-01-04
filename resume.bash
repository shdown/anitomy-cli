#!/usr/bin/env bash

ANITOMY_CLI=~/repo/anitomy-cli/anitomy-cli

if (( $# != 1 )); then
    echo >&2 "USAGE: ${0##*/} <directory>"
    exit 2
fi
cd -- "$1" || exit $?

files=()
while IFS= read -rd '' file; do
    files+=("$file")
done < <(
    find -type f -regextype posix-extended -iregex '.*\.(mkv|mp4)' -print0 \
        | $ANITOMY_CLI -z sort)

exec ${MPV:-mpv} \
    --script=~/.config/mpv/resume.lua \
    --script-opts=re-anitomy-cli-cmd="$ANITOMY_CLI" \
    --save-position-on-quit \
    --keep-open \
    --pause=no \
    -- "${files[@]}"
