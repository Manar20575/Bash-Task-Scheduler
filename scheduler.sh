#!/bin/bash

#files
task_file="$HOME/.scheduler_tasks"
log_file="$HOME/.scheduler_log"

#create files
touch task_file log_file

#log message
log() {
	echo "[$(date +'%F %T')]"
}

#Listing all schedule tasks
list_tasks() {
	if [[ ! -s "$task_file" ]]
	then
		echo "No Scheduled Tasks"
	else
		echo -e "ID\tInterval\tCommand"
		echo "------------------------"
		#extract the tasks then reformat from a pipe
		cat "$task_file" | awk -F'|' '{printf "%s\t%s\t%s\n", $1, $2, $3}'
	fi
}

#add task
add_task() {
	echo "Select task interval:"
	echo "1- Minute"
	echo "2- Hourly"
	echo "3- Daily"
	echo "4- Weekly"
	echo "5- Monthly"
	read -p "Enter choice (1..5)" interval_ch
	
	#cron expressions
	case $interval_ch in
		1) interval="* * * * *";; #every minute
		2) interval="0 * * * *";; #every hour
		3) interval="0 0 * * *";; #daily
		4) interval="0 0 * * 0";; #weekly
		5) interval="0 0 1 * *";; #monthly 
		*) echo "Invalid Choice";return 1 ;;
	esac
	
	#get the command to execute
	read -p "Plz, Enter command to execute: " command

	#generate ID for task based on timestamp
	id=$(date +%s)
	#redirect the task to file tasks
	echo "$id|$interval|$command" >> "$task_file"
	log "Added new task: ID=$id, Interval=$interval, Command=$command"
	echo "Task added successfully with ID: $id"
}

#remove task
remove_task(){
	list_tasks
	read -p "Enter ID of task to remove: " task_id
	if grep -q "^$task_id|" "$task_file"
	then
		grep -v "^$task_id|" "$task_file" > "$task_file.tmp"
		mv "$task_file.tmp" "$task_file"
		log "Removed task with ID: $task_id "
		echo "Task removed successfully."
	else
		echo "Task ID not exist"
	fi
}

#crone functions 
#1. passes tasks to crontab

install_to_cron() {
	#check if there is tasks or not(not exist or empty)
	if [[ ! -s "$task_file" ]]
	then
		echo "NO Tasks To Install"
		return
	fi
	
	#list cronetab tasks then redirect it to backup dir
	crontab -l > "$HOME/.crontab_backup" 2>/dev/null
	log "Created crontab backup at $HOME/.crontab_backup"

	while IFS='|' read -r id interval command
	do
		(crontab -l 2>/dev/null; echo "$interval $command # TaskScheduler_ID=$id") | crontab -
	done < "$task_file"
	log "Tasks installed to crontab"
	echo "All tasks installed to crontab"
}

uninstall_from_cron() {
	crontab -l | grep -v "TaskScheduler_ID=" | crontab -
	log "Removed all TaskScheduler tasks from crontab"
	echo "All TaskScheduler tasks removed from crontab "
}

main_menu(){
	while true
	do
		echo -e "\nTask Scheduler Options: "
		echo "1- List Scheduled tasks"
		echo "2- Add a task"
		echo "3- Remove a task"
		echo "4- Install tasks from crontab"
		echo "5- Remove tasks from crontab"
		echo "6- Exit"
		read -p "Enter your choice (1..6): " choice

		case $choice in
			1) list_tasks ;;
			2) add_task ;;
			3) remove_task ;;
			4) install_to_cron ;;
			5) uninstall_from_cron ;;
			6) exit 0 ;;
			*) echo "Invalid Option" ;;
		esac
	done
}

main_menu
