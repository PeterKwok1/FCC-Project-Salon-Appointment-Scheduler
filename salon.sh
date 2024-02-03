#!/bin/bash

# --tuples-only disables printing column name, etc. Idk what -X does. 
PSQL="psql -X --username=freecodecamp --dbname=salon --tuples-only -c"

($PSQL "TRUNCATE customers, appointments;")

echo -e "\n~~~~~ MY SALON ~~~~~\n"

MAIN_MENU(){

  if  [[ $1 ]] 
  then
    echo -e "\n$1"
  fi

  echo Welcome to My Salon, how can I help you?
  AVAILABLE_SERVICES=$($PSQL "SELECT service_id, name FROM services")
  if [[ -z $AVAILABLE_SERVICES ]] 
  then
    MAIN_MENU "Sorry, we don't have any services available right now."
  else
    echo -e "\nWhich service would you like?"
    echo "$AVAILABLE_SERVICES" | while read SERVICE_ID BAR SERVICE_NAME
    do
      echo -e "$SERVICE_ID) $SERVICE_NAME"
    done

    read SERVICE_ID_SELECTED
    if [[ -z $($PSQL "SELECT service_id FROM services WHERE service_id=$SERVICE_ID_SELECTED") ]]
    then
      MAIN_MENU "I could not find that service. What would you like today?"
    fi

    echo -e "\nWhat's your phone number?"
    read CUSTOMER_PHONE
    if [[ -z $($PSQL "SELECT phone FROM customers WHERE phone='$CUSTOMER_PHONE'") ]]
    then
      echo -e "\nI don't have a record for that phone number, what's your name?"
      read CUSTOMER_NAME
      INSERT_CUSTOMER_RESULT=$($PSQL "INSERT INTO customers(phone, name) VALUES('$CUSTOMER_PHONE', '$CUSTOMER_NAME')")
    fi
    CUSTOMER_ID=$($PSQL "SELECT customer_id FROM customers WHERE phone='$CUSTOMER_PHONE' AND name='$CUSTOMER_NAME'")

    read SERVICE_TIME

    INSERT_APPOINTMENT_RESULT=$($PSQL "INSERT INTO appointments(customer_id, service_id, time) VALUES($CUSTOMER_ID, $SERVICE_ID_SELECTED, '$SERVICE_TIME')")
  
  fi

}

MAIN_MENU