#!/bin/bash

PSQL="psql --username=freecodecamp --dbname=salon -c"

echo -e "\n~~~~~ MY SALON ~~~~~\n"

MAIN_MENU(){

  if  [[ $1 ]] 
  then
    echo -e "\n$1"
  fi

  echo Welcome to My Salon, how can I help you?
  echo -e "\n1) cut\n2) color\n3) perm\n4) style\n5) trim"
  read SERVICE_ID_SELECTED
  if [[ -z $($PSQL "SELECT service_id FROM services WHERE service_id=$SERVICE_ID_SELECTED") ]]
  then
    MAIN_MENU "I could not find that service. What would you like today?"
  fi
  
  echo -e "\nWhat's your phone number?"
  read CUSTOMER_PHONE
  if [[ -z $($PSQL "SELECT phone FROM customers WHERE phone=$CUSTOMER_PHONE") ]]
  then
    echo -e "\nI don't have a record for that phone number, what's your name?"
    read CUSTOMER_NAME
    # INSERT_CUSTOMER_RESULT=$($PSQL "")
  fi

}

MAIN_MENU