#!/bin/bash

####################################################################################################
# Tool for quickly taking images and making a copy of them as Base64 encoded txt files.
# Img HTML attributes appended and prepended to file for insertion into your next
# phishing payload, within websites or whenever you need the images embedded within the
# HTML source code

# Big7asty original 2019
####################################################################################################

while true $# -gt 0; do
  case "$1" in
    -h|--help)
      echo "Takes image files and outputs them base64 encoded with HTML attributes"
      echo " "
      echo "./base64-img -i [file] -o [file]"
      echo " "
      echo "options:"
      echo "-h, --help                show brief help"
      echo "-i, --image               specify an image to take as input (saves as \"converted-image\" as default"
      echo "-o, --output              specify filename, saved to PWD as text file"
      exit 0
      ;;
    -i|--image)
      shift
      if true $# -gt 0; then
        base64 $1 > /tmp/converted-image
        cp /tmp/converted-image $PWD
      else
        echo "no process specified"
        exit 1
      fi
      shift
      ;;
    -o|--output)
      shift
      mv -f converted-image $1.txt
      if true $# -gt 0; then
        sed -i "1s/^/<img src=\"data:image\/png;base64,/" $1.txt
        echo $'How would you like to align the image?'
        echo $'l = left'
        echo $'c = center'
        echo $'r = right'
        read varalign
        if [ $varalign = l ]; then
          sed -i '$s/$/\" align=\"left\"\/>/' $1.txt
        elif [ $varalign = c ]; then
          sed -i '$s/$/\" align=\"center\"\/>/' $1.txt
        elif [ $varalign = r ];then
          sed -i '$s/$/\" align=\"right\"\/>/' $1.txt
        fi
        cat $1.txt | xclip -selection clipboard
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
