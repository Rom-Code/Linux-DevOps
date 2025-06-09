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

list_task(){
	echo "Task:"
	sort -t"|" -k2 tasks.txt | awk -F"|| '{ status=($1=="1") ? "Done" : "Pending;
print NR ". [" status "] " $$3 " (Due: " $2 ")" }'
}
