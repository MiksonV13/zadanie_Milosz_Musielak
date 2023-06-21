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


display_help() {
    echo "Użycie: skrypt.sh [OPCJA]"
    echo "Opcje:"
    echo "  -h, --help     Wyświetla pomoc"
    echo "  -l, --logs     Tworzy pliki logx.txt (x = 1-100) z informacjami"
    echo "  -d, --date     Wyświetla dzisiejszą datę"
    echo "      --init     Klonuje repozytorium i ustawia ścieżkę w zmiennej PATH"
    echo "  -e, --error    Tworzy pliki errorx/errorx.txt (x = 1-100)"
    echo "                 Jeśli nie podano liczby, domyślnie tworzy 100 plików"
}

create_logs() {
    for ((i = 1; i <= 100; i++)); do
        filename="log${i}.txt"
        echo "Nazwa pliku: $filename" >"$filename"
        echo "Utworzone przez skrypt.sh" >>"$filename"
        date >>"$filename"
    done
    echo "Utworzono 100 plików logx.txt"
}

display_date() {
    date
}

initialize_repository() {
    git clone https://github.com/twoje-repozytorium.git
    export PATH="$PATH:$(pwd)"
    echo "Repozytorium zostało sklonowane, ścieżka ustawiona w zmiennej PATH"
}

create_error_files() {
    count=$1
    if [[ -z $count ]]; then
        count=100
    fi
    for ((i = 1; i <= count; i++)); do
        filename="error${i}/error${i}.txt"
        mkdir -p "$(dirname "$filename")"
        echo "Nazwa pliku: $filename" >"$filename"
        echo "Utworzone przez skrypt.sh" >>"$filename"
        date >>"$filename"
    done
    echo "Utworzono $count plików errorx/errorx.txt"
}


case "$1" in
-h | --help)
    display_help
    ;;
-l | --logs)
    create_logs
    ;;
-d | --date)
    display_date
    ;;
--init)
    initialize_repository
    ;;
-e | --error)
    shift
    create_error_files "$@"
    ;;
*)
    echo "Nieznana opcja. Użyj --help/-h, aby wyświetlić pomoc."
    ;;
esac