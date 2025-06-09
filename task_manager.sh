#!/bin/bash

RED=$(tput setaf 1)
GREEN=$(tput setaf 2)
YELLOW=$(tput setaf 3)
RESET=$(tput sgr0)


create_task_file(){
	if [ ! -f tasks.txt ]; then
	touch tasks.txt
	echo "Task file created."
	fi
}

add_task(){
	read -p "Enter Task description: " desc
	read -p "Enter due date (YYYY-MM-DD): " due
	echo "o}$due}$desc" >> tasks.txt
	echo "Task added."
}

list_tasks() {
  echo "Tasks:"
  sort -t"|" -k2 tasks.txt | awk -F"|" -v red="$RED" -v green="$GREEN" -v yellow="$YELLOW" -v reset="$RESET" '{
    status=($1=="1") ? green "Done" reset : yellow "Pending" reset;
    print NR ". [" status "] " $3 " (Due: " $2 ")";
  }'
}


complete_task() {
  list_tasks
  read -p "Enter task number to mark as completed: " num
  sed -i "${num}s/^0/1/" tasks.txt
  echo "Task marked as completed."
}

delete_task() {
  list_tasks
  read -p "Enter task number to delete: " num
  sed -i "${num}d" tasks.txt
  echo "Task deleted."
}

search_tasks() {
  read -p "Enter keyword to search: " keyword
  grep -i "$keyword" tasks.txt | awk -F"|" '{ status=($1=="1") ? "Done" : "Pending"; print "[" status "] " $3 " (Due: " $2 ")" }'
}


choice=$(dialog --clear --backtitle "Task Manager" \
  --title "Main Menu" \
  --menu "Choose an option:" 15 50 6 \
  1 "Add task" \
  2 "List tasks" \
  3 "Complete task" \
  4 "Delete task" \
  5 "Search tasks" \
  6 "Exit" 3>&1 1>&2 2>&3)

clear

case $choice in
  1) add_task ;;
  2) list_tasks ;;
  3) complete_task ;;
  4) delete_task ;;
  5) search_tasks ;;
  6) exit 0 ;;
esac
