#!/usr/bin/env bash
# Problem
# The production support team of xFusionCorp Industries is working on developing some bash scripts to automate different day to day tasks.
# One is to create a bash script for taking websites backup.
# They have a static website running on App Server 3 in Stratos Datacenter, and they need to create a bash script named official_backup.sh which should accomplish the following tasks.
# (Also remember to place the script under /scripts directory on App Server 3)
# a. Create a zip archive named xfusioncorp_official.zip of /var/www/html/official directory.
# b. Save the archive in /backup/ on App Server 3. This is a temporary storage, as backups from this location will be clean on weekly basis.
#    Therefore, we also need to save this backup archive on Nautilus Backup Server.
# c. Copy the created archive to Nautilus Backup Server server in /backup/ location.
# d. Please make sure script won't ask for password while copying the archive file.
#    Additionally, the respective server user (for example, tony in case of App Server 1) must be able to run it.

# Login as root
sudo su -

# Variables
export BACKUP=official

# Create and save the script
cat <<EOT > /scripts/"$BACKUP"_backup.sh
#!/bin/bash
zip -r /backup/xfusioncorp_$BACKUP.zip /var/www/html/$BACKUP
scp /backup/xfusioncorp_$BACKUP.zip clint@stbkp01:/backup/
EOT

# Create ssh keygen without prompts
yes '' | ssh-keygen -N ''

# Copy pub key to backup server
# Still manual
ssh-copy-id clint@stbkp01 # You need to enter the password

# Set script as executable
chmod +x /scripts/$BACKUP_backup.sh
