#!/bin/bash

create_task_file(){
	if [ ! -f tasks.txt ]; then
	touch tasks.txt
	echo "Task file created."
	fi
}
