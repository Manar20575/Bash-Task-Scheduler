# Task Scheduler - Bash Script
Project Idea from LabEx https://labex.io/courses/project-build-a-task-scheduler-using-bash
A simple bash script allows you to schedule and manage recurring tasks with different time intervals (minutely, hourly, daily, weekly, monthly). The script provides an interactive menu to add, remove, and manage tasks.
</br>
![Demo](https://github.com/Manar20575/Task-Scheduler/blob/main/Bash-Task-Scheduler.gif)
## ✨ Features
### Task Scheduling Options
- ⏱️ **Minutely** - Run every minute
- 🕒 **Hourly** - Run at the top of every hour  
- 🌞 **Daily** - Run at midnight each day
- 📅 **Weekly** - Run every Sunday at midnight
- 📆 **Monthly** - Run on the 1st of each month

### Task Management
- 📋 **List all scheduled tasks** - View all configured tasks
- ✅ **add task** - add specific task
- ❌ **Remove task by ID** - Delete specific task
- **Install tasks to crontab** - Deploy tasks to system cron
- **Uninstall tasks from crontab** - Remove all tasks from corn

## 📂 File Structure

- **`scheduler.sh`**  
  The main executable script file

- **`~/.scheduler_tasks`**  
  Stores all your scheduled tasks in pipe-delimited format (automatically created)

- **`~/.scheduler_log`**  
  Records all operations with timestamps (automatically created)

- **`~/.crontab_backup`**  
  Safety backup of your original crontab (created before any modifications)

## 🚀 Installation
### Prerequisites
- Linux system
- Bash shell
- cron daemon running

### Clone Repository
```bash
# Clone the repository
git clone https://github.com/yourusername/Bash-Task-Scheduler.git

# Navigate to project directory
cd name_of_urdir
```

# Set Up Permissions
```bash
# Make the script executable
chmod +x scheduler.sh

# Start the interactive menu
./scheduler.sh
```
