#!/usr/bin/env zsh

## Meanings of exit codes:
## code | meaning    | action of ranger
## -----+------------+-------------------------------------------
## 0    | success    | Display stdout as preview
## 1    | no preview | Display no preview at all
## 2    | plain text | Display the plain content of the file
## 3    | fix width  | Don't reload when width changes
## 4    | fix height | Don't reload when height changes
## 5    | fix both   | Don't ever reload
## 6    | image      | Display the image `$IMAGE_CACHE_PATH` points to as an image preview
## 7    | image      | Display the file directly as an image

filepath=$1
width=$2
height=$3

by_extension() {
    case ${filepath:e} in
        a|ace|alz|arc|arj|bz|bz2|cab|cpio|deb|gz|jar|lha|lz|lzh|lzma|lzo|rpm|rz|t7z|tar|tbz|tbz2|tgz|tlz|txz|tZ|tzo|war|xpi|xz|Z|zip)
            timeout 1 bsdtar --list --file "${filepath}" | tfold $width && exit 3;;
        rar)
            unrar lt -p- -- "${filepath}" | tfold $width && exit 3;;
        7z)
            7z l -p -- "${filepath}" | tfold $width && exit 3;;
        pdf)
            pdftotext -l 10 -nopgbrk -q -- "${filepath}" - | tfold $width && exit 3;;
        json)
            python -m json.tool -- "${filepath}" | tfold $width && exit 3;;
    esac
}

by_mime() {
    mime=$(file --dereference --brief --mime-type -- "$filepath")
    case $mime in
        text/* | */xml)
            tfold $width < $filepath && exit 3;;

        # too slow & covered by fallback
        # image/*)
        #     identify -format "%m %wx%h %[bit-depth]-bit %[colorspace]\n" "$filepath" | tfold $width && exit 3;;

        video/* | audio/*)
            ffprobe -hide_banner "$filepath" | tfold $width && exit 3;;
    esac
}

by_extension
by_mime

(echo '----- File Type Classification -----' && file --dereference --brief -- "$filepath") | tfold $width && exit 3
exit 1
