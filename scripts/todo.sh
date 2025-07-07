#!/usr/bin/env bash

TODO_FILE="$HOME/asahi-scripts/text-files/TODO.txt"
touch "$TODO_FILE"

add_task () {
    echo "[] $1" >> "$TODO_FILE"
    echo "✅ Added: \"$1\""
}

show_tasks () {
    if [ ! -s "$TODO_FILE" ]; then
        echo "📭 Your TODO list is empty!"
    else
        nl -w2 -s'. ' "$TODO_FILE"
    fi
}

delete_task () {
    local line_num=$1
    sed -i "${line_num}d" "$TODO_FILE"
    echo "🗑️ Removed Task: #$line_num"
}

while getopts "a:sd:" flag; do
  case "$flag" in
    a)
      add_task "$OPTARG"
      ;;
    s)
      show_tasks
      ;;
    d)
      delete_task "$OPTARG"
      ;;
    *)
      echo "❓ Unknown option"
      ;;
  esac
done

