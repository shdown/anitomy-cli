#!/usr/bin/env bash

ANITOMY_CLI=~/repo/anitomy-cli/anitomy-cli

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
