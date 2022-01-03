#!/usr/bin/env bash
#: Jake Martin
#: Contact list bash script that manages contacts.
#: WARNING - contact list is saved to a hidden directory.
#: Hidden file can be found at ~/.contacts/contact_list


#: color constants...
R='\033[0;31m'
G='\033[0;32m'
B='\033[0;34m'
Y='\033[1;33m'
NoColor='\033[0m'

#: echo first arg passed in 50 times.
repeater () {
  for num in {1..50}; do echo -e -n "$1"; done
}

#: Path verification and writing to contact list file.
verifyDir () {
  printf "\nFinding Contact List..."
  if [[ -d "$HOME/.contacts" ]]
  then
    printf "\nDirectory found.\n"
  else
    printf "${R}\nContact List not found.${NoColor}\n\nCreating new directory...\n"
    mkdir $HOME/.contacts
    printf "Directory '~/.contacts' successfully created.\n"
    printf "\nCreating new contact_list file...\n"
    repeater "=" >> $HOME/.contacts/contact_list
    printf "\n\t\tContact List\n" >> $HOME/.contacts/contact_list
    repeater "=" >> $HOME/.contacts/contact_list
    printf "\n\n" >> $HOME/.contacts/contact_list
    printf "contact_list file created @ ~/.contacts/contact_list\n\n"
  fi
}

#: Add a contact to the contact list file.
addContact () {
  verifyDir
  echo -e "${Y}"
  read -p "Enter contact name to add: " name
  read -p "Enter a contact email to add: " email
  read -p "Enter a contact address to add: " address
  read -p "Enter contact phone number(s) to add: " phone
  echo -e "${NoColor}"
  printf "\nName:\t\t\t$name\nEmail:\t\t\t$email\n" >> $HOME/.contacts/contact_list
  printf "Address:\t\t$address\nPhone:\t\t\t$phone\n\n" >> $HOME/.contacts/contact_list
  printf "${G}\nSuccessfully added $name to contact_list file.${NoColor}"
}

#: Remove a contact from the contact list file.
removeContact () {
  displayContacts
  read -p "Enter a contact name to remove their info (case sensitive): " contact
  read -p "Are you sure you want to remove $contact? (y/N): " ans
  case $ans in
    Y | y) export contact;
           perl -000 -i -ne 'print unless /$ENV{contact}/' $HOME/.contacts/contact_list;
           clear;
           printf "${G}\n$contact's contact information has been successfully removed.\n${NoColor}";
           displayContacts;;
    *) clear;
       printf "${R}\n$contact was NOT removed.\n${NoColor}";
       displayContacts;;
  esac
}

#: Display all the contacts on the contact list file.
displayContacts () {
  verifyDir
  printf "Displaying contact_list file...\n\n"
  cat ~/.contacts/contact_list
}

#: Gives options to user.
selectOption () {
  clear
  while true; do
    repeater "${G}#"
    printf "${NoColor}\n                  CONTACT-LIST\n${G}"
    repeater "#"
    printf "${B}\n\n    -> [${NoColor}A${B}]dd contact\n    -> [${NoColor}R${B}]emove contact\n"
    printf "    -> [${NoColor}D${B}]isplay contact\n    -> [${NoColor}H${B}]elp\n    -> [${NoColor}E${B}]xit program\n\n${NoColor}"

    read -p "Select an option: " option

    case $option in
      A | a) clear; addContact; break;;
      R | r) clear; removeContact; break;;
      D | d) clear; displayContacts; break;;
      H | h) clear; helpGeneral; break;;
      E | e | exit)
             clear
             printf "\n\nExiting contact-list...\n"
             exit 0;;
      *) clear; printf "${R}Invalid option. Please try again.\n\n${NoColor}";;
    esac
  done
}

#: Send help info to the user.
helpGeneral () {
  printf "${B}CONTACT LIST HELP PAGE\n\n"
  printf "Press <Enter> after choosing one of the options below\n\n${NoColor}"
  printf "Add a contact: [a] or [A]\nRemove a contact: [r] or [R]\n"
  printf "Display contact list: [d] or [D]\nGet this help information: [h] or [H]\n"
  printf "Exit the contact-list program: [e] or [E]\n\n"
}

#: Handle how the user exits the program.
exitStrat () {
  while true; do
    printf "\n\n"
    read -p "Exit the contact-list program? (y/N): " choice
    case $choice in
      Y | y) clear; printf "Exiting contact-list...\n\n"; exit 0;;
      '' | N | n) selectOption;;
      *) echo -e "${R}Invalid choice. 'Y, y, or <enter>' to exit. 'N or n' to continue.${NoColor}";;
    esac
  done
}

#: Start the program and call the exit strategy.
main () {
  if [[ "$1" != '' ]]; then
    echo -e "${R}contact-list does not take arguments.${NoColor}"
    echo "Usage: ./contact-list"
    exit 1
  fi
  selectOption
  exitStrat
}
main

