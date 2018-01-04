A command-line interface for [anitomy](https://github.com/erengy/anitomy).

`resume.bash` is a script that uses `anitomy-cli` and `resume.lua` [mpv](https://mpv.io) script to sort video files in a given directory, and either start or resume playback from the position you quit on.

(TODO: write a man page.)

````
SYNOPSIS
    anitomy-cli [-S] [-V] [-z] action

OPTIONS
    -S: extract season numbers
    -V: extract volume numbers
    -z: input and output are zero-delimited

ACTIONS
    sort
        sort files by
            1) volume number (only if -S was passed)
            2) season number (only if -V was passed)
            3) episode number

        Example:
            Input:
                02.mkv
                ep01.mkv

            Output:
                ep01.mkv
                02.mkv

    attach
        decide which external files belong to which videos

        In input, video files and external files (subtitles/audios) should be
        separated by an empty line.

        Output is empty-line separated blocks. Each block starts with a name of
        video file and then lists external files belonging to it.

        It is guaranteed that the order of blocks is the same that that of
        input.
        It is guaranteed that within a block, external files are sorted
        alphabetically.

        Example:
            Input:
                ep01.mkv
                ep02.mkv
                ep03.mkv
                ep04.mkv

                01.ass
                02.ass
                ep01.ass
                foo.ass

            Output:
                ep01.mkv
                01.ass
                ep01.ass

                ep02.mkv
                02.ass

                ep03.mkv

                ep04.mkv
````
