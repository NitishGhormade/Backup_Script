# Backup Script 📦

A simple and efficient **Backup Script** written in **Bash**. This script compresses files and folders on a timely basis and stores the compressed backups on your system. Ideal for automating routine backups and ensuring your data is safe.  

## ✨ Features

- 🗂️ **Backup Files and Folders**  
  Automatically compresses files and folders into `.tar.gz` archives.  

- ⏰ **Scheduled Backups**  
  Run backups on a daily, weekly, or custom schedule using cron jobs.  

- 📂 **Customizable Storage Location**  
  Specify the destination directory for storing backup archives.  

- 🧹 **Automatic Cleanup**  
  Option to delete older backups to save space.  

- 📜 **Logging**  
  Maintains a log file to track backup activities.  

## 🚀 Tech Stack

- **Language**: Bash  
- **Compression**: `tar` with `gzip`  
- **Scheduler**: Cron  

## 🛠️ Installation  

1. Clone this repository:  
   ```bash
   git clone https://github.com/yourusername/backup-script.git
