#!/bin/bash

if [ $# -ne 2 ]; then
  echo "Usage: $0 <IP_ADDRESS> <WORDLIST>"
  exit 1
fi

IP_ADDRESS=$1
WORDLIST=$2

if ! [ -f "$WORDLIST" ]; then
  echo "Wordlist '$WORDLIST' not found."
  exit 1
fi

while read -r username; do
  finger "$username"@"$IP_ADDRESS" | grep -q "Name:"
  if [ $? -eq 0 ]; then
    echo "Username $username exists at $IP_ADDRESS"
  fi
done < "$WORDLIST"
