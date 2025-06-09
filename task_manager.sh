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

