#!/bin/bash

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
  sort -t"|" -k2 tasks.txt | awk -F"|" '{ status=($1=="1") ? "Done" : "Pending"; print NR ". [" status "] " $3 " (Due: " $2 ")" }'
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

show_menu() {
  echo "1) Add task"
  echo "2) List tasks"
  echo "3) Mark task as completed"
  echo "4) Delete task"
  echo "5) Search tasks"
  echo "6) Exit"
}

while true; do
  show_menu
  read -p "Choose an option: " choice
  case $choice in
    1) add_task ;;
    2) list_tasks ;;
    3) complete_task ;;
    4) delete_task ;;
    5) search_tasks ;;
    6) echo "Goodbye!"; break ;;
    *) echo "Invalid option." ;;
  esac
  echo ""
done
