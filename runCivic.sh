#!/bin/bash
set -e

#!/bin/bash
function finish {
    for f in $files; do
        rm -f "$f.as__"
        rm -f "$f.out__"
    done
}

trap finish EXIT

# Dir with the compiler assembler and vm.
# Change to where the toolchain is stored
bin='/home/jelle/TA/2018-2019/CoCo/toolchain-uva-linux-x64/bin'

comp_run() {
    # Read all cmd line args.
    files=$@
    outFiles=()

    # Exit if no files given.
    if [[ ( $# == 0 ) ]]; then
        exit
    fi

    for f in $files; do
        $bin/civcc -o "$f.as__" $f
    done

    for f in $files; do
        $bin/civas -o "$f.out__" "$f.as__"
        outFiles+="$f.out__ "
    done

    $bin/civvm $outFiles

    # Remove temp files.
    for f in $files; do
        rm "$f.as__"
        rm "$f.out__"
    done
}

comp_run $@
