#!/usr/bin/env bash
#: Jake Martin
#: Output the links from a web page and
#: optionally save them to a file.
#: File location: URL_getter_results in working directory


#: color constants...
R='\033[0;31m'
G='\033[0;32m'
B='\033[0;34m'
Y='\033[1;33m'
NoColor='\033[0m'
#: filter for links in index.html...
filter_links='grep -Eo "(http|https)://[a-zA-Z0-9./?=_%:-]*"'

#: Print help and usage info to the user.
help () {
  printf "${B}\n\t\tHELP\n${NoColor}"
  printf "\nYou need to pass a link/URL as an argument"
  printf "\nUse -f to save links to URL_getter_results"
  printf "\nNote: URL_getter_results is saved in the working directory.\n\n"
  printf "${Y}Usage: ./url-getter [-f] [url_to_filter]\n\n${NoColor}"
  printf "OR if you don't want to save links...\n\n"
  printf "${Y}Usage: ./url-getter [url_to_filter]\n\n${NoColor}"
  exit 1
}

#: Print info about failed wget.
cannotFindLink () {
  echo -e "${R}index.html not found."
  echo -e "Argument passed may not be a URL.${NoColor}"
  echo "For more information: ./url-getter -h"
  exit 1
}

while getopts ":f:h" opt; do
  case $opt in
    f )
      #: Get URLs index.html, filter for links and save them in a file.
      #: Also test if wget runs successfully.
      wget -q $OPTARG
      if [[ "$?" -ne 0 ]]; then
        cannotFindLink
      else
        cat index.html | $filter_links
        echo `cat index.html | $filter_links` > to_format
        awk -v RS=' ' '{print}' to_format >> URL_getter_results
        rm -f index.html to_format
        printf "${G}\nLinks saved to URL_getter_results\n\n${NoColor}"
        exit 0
      fi
      ;;
    h )
      help
      ;;
    \? )
      printf "${R}\n-$OPTARG is not an option\n${NoColor}"	
      echo "For more information: ./url-getter -h"
      exit 1
      ;;
    : )
      printf "${R}\n-$OPTARG requires an argument\n${NoColor}"
      echo "For more information: ./url-getter -h"
      exit 1
      ;;
  esac
done

#: If no URL is passed, print help information.
if [[ "$1" == '' ]]; then
  #: If nothing is passed, run help function.
  echo -e "${R}Invalid usage.${NoColor}"
  echo "For more information: ./url-getter -h"
  exit 1
else
  #: Test if wget runs successfully.
  wget -q $1
  if [[ "$?" -ne 0 ]]; then
    cannotFindLink
  else
    cat index.html | $filter_links
    rm -f index.html
    exit 0
  fi
fi

