#!/bin/bash

if [[ "$1" == "--date" ]]; then
  echo $(date)
elif [[ "$1" == "--logs" ]]; then
  if [[ "$2" =~ ^[0-9]+$ ]]; then
    count=$2
  else
    count=100
  fi

  for ((i=1; i<=$count; i++)); do
    filename="log$i.txt"
    echo -e "Nazwa pliku: $filename\nNazwa skryptu: $0\nData: $(date)" > $filename
  done
elif [[ "$1" == "--help" ]]; then
  echo "Dostępne opcje:"
  echo "--date - wyświetla dzisiejszą datę"
  echo "--logs [liczba] - tworzy 100 (lub podaną liczbę) plików logx.txt i zapisuje w nich informacje"
else
  echo "Nieznana opcja. Użyj --help, aby wyświetlić dostępne opcje."
fi