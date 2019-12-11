#!/bin/bash

####################################################################################################
# Tool for quickly taking images and making a copy of them as Base64 encoded txt files.
# Img HTML attributes appended and prepended to file for insertion into your next
# phishing payload, within websites or whenever you need the images embedded within the
# HTML source code

# Big7asty original 2019
####################################################################################################

while test $# -gt 0; do
  case "$1" in
    -h|--help)
      echo "$Takes image files and outputs them base64 encoded with HTML attributes"
      echo " "
      echo "./base64-img -i [file] -o [file]"
      echo " "
      echo "options:"
      echo "-h, --help                show brief help"
      echo "-i, --image               specify an image to take as input (saved to /tmp/base64-img)"
      echo "-o, --output              specify filename, saved to PWD as text file"
      exit 0
      ;;
    -i|--image)
      shift
      if test $# -gt 0; then
        base64 $1 > /tmp/base64-img
      else
        echo "no process specified"
        exit 1
      fi
      shift
      ;;
    -o|--output)
      shift
      if test $# -gt 0; then
        cp /tmp/base64-img $PWD/$1.txt
	sed -i "1s/^/<img src=\"/" $1.txt
	sed -i '$s/$/\/>/' $1.txt
	cat test | xclip -selection clipboard
      else
        echo "no output dir specified"
        exit 1
      fi
      shift
      ;;
    *)
      break
      ;;
  esac
done

echo "Image Base64 HTML code copied to clipboard!"
