#!/bin/zsh

FILE_PATH="$1"
WIDTH="$2"
HEIGHT="$3"
EXTENSION="$FILE_PATH:t:e"

function handle_extension() {
    case "$EXTENSION" in 
        a|ace|alz|arc|arj|bz|bz2|cab|cpio|deb|gz|jar|lha|lz|lzh|lzma|lzo|rpm|rz|t7z|tar|tbz|tbz2|tgz|tlz|txz|tZ|tzo|war|xpi|xz|Z|zip)
            timeout 1 bsdtar --list --file "${FILE_PATH}" && exit 5
            exit 1;;
        rar)
            unrar lt -p- -- "${FILE_PATH}" && exit 5
            exit 1;;
        7z)
            7z l -p -- "${FILE_PATH}" && exit 5
            exit 1;;
        pdf)
            pdftotext -l 10 -nopgbrk -q -- "${FILE_PATH}" - | fmt -w "${WIDTH}" && exit 5
            exit 1;;
        json)
            python -m json.tool -- "${FILE_PATH}" && exit 5
            exit 1;;
    esac
}

function handle_mime() {
    mime="$(file --dereference --brief --mime-type -- "${FILE_PATH}")"
    text=''
    case "$mime" in
        text/* | */xml)
            text="$(cat "$FILE_PATH")";;

        # image/*)
        #     text="$(identify -format "%m %wx%h %[bit-depth]-bit %[colorspace]\n" "$FILE_PATH")";;

        video/* | audio/*)
            text="$(ffprobe -hide_banner "$FILE_PATH")";;
        
    esac

    if [[ ! -z $text ]] {
        echo "${text}" | tfold "$WIDTH" && exit 4
    }
}

handle_fallback() {
    echo '----- File Type Classification -----' && file --dereference --brief -- "${FILE_PATH}" && exit 5
    exit 1
}

handle_extension
handle_mime
handle_fallback
exit 1
