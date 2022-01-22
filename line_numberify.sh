#!/usr/bin/env bash
#: Jake Martin
#: Output a file with line numbers.


input=$1
count=1
# tempFile="${input}_withLineNums"
G='\033[0;32m'
C='\033[0m'

#: Check options and determine course of action.
# while getopts ":n:h" option; do
#   case $option in
#     n)#: Print file out with line numbers.
#       printf "${G}\nAdding line numbers to file...${C}\n\n"
#       while read -r line
#       do
#         echo "$count. $line"
#         count=$((count+1))
#       done < $OPTARG
#       exit 0;;
#     h)#: Print help info for the user.
#       printf "\nThis script allows you show your files with line numbers."
#       printf "\nShow lines: ./line-numberify <file_name>\n"
#       printf "Show lines with line numbers: ./line-numberify -n <file_name>\n\n"
#       exit 1;;
#     *)#: Catch invalid options.
#       printf "\n-$OPTARG is not an option."
#       printf "\nFor help: ./line-numberify -h\n"
#       exit 1;;
#   esac
# done

#: If no file is passed, show usage information.
if [[ "$input" == '' ]]
then
  printf "\n\tMust pass in a file as an argument to add line numbers to it.\n"
  # echo " ./line-numberify -h"
else
  printf "${G}\nAdding line numbers to file...${C}\n\n"
  while read -r line
  do
    echo "$count. $line"
    count=$((count+1))
  # done < $OPTARG
  # while read -r line
  # do
  #   echo "$line"
  done < $input
  exit 0
fi

