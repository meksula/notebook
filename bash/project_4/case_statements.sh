#!/bin/bash

# W tej lekcji podstawowa składnia instrukcji if oraz case

if [[ "${1}" = 'sudo' ]]
then 
   echo "Script is running with super user privilages"
elif [[ "${1}" = 'standard' ]]
then
   echo "Script is running in standard mode"
elif [[ "${1}" = 'status' ]]
then
   echo "OK"
else
   echo "Command $1 not recognized" 1>&2 
fi 


# case expression syntax
# p ipe | oznacza operator 'or'

case "${1}" in 
   sudo|su)
      echo 'Script executed with sudo'
      ;;
   standard|normal)
      echo 'Script executed in standard mode'
      ;;
   status|state)
      echo 'Status command'
      ;;
   *)
      echo 'Other option'
     ;;
esac 


