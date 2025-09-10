15. Scripting with Cron and Automation

File: `15_cron_automation.sh`

#!/bin/bash
# =============================================================================
# SCRIPTING WITH CRON AND AUTOMATION - Complete Guide
# =============================================================================

set -euo pipefail

# =============================================================================
# CRON BASICS AND SYNTAX
# =============================================================================

echo "=== CRON BASICS AND SYNTAX ==="

demo_cron_basics() {
    echo "Understanding cron job syntax:"
    
    echo -e "\nCron job format:"
    echo "  * * * * * command"
    echo "  │ │ │ │ │"
    echo "  │ │ │ │ └── Day of week (0-7, 0 or 7 = Sunday)"
    echo "  │ │ │ └──── Month (1-12)"
    echo "  │ │ └────── Day of month (1-31)"
    echo "  │ └──────── Hour (0-23)"
    echo "  └────────── Minute (0-59)"
    
    echo -e "\nCommon cron expressions:"
    cat << 'EOF'
  0 0 * * *     # Daily at midnight
  0 12 * * *    # Daily at noon
  0 0 * * 0     # Weekly on Sunday at midnight
  0 0 1 * *     # Monthly on the 1st at midnight
  0 0 1 1 *     # Yearly on January 1st at midnight
  */5 * * * *   # Every 5 minutes
  0 */2 * * *   # Every 2 hours
  30 9 * * 1-5  # 9:30 AM on weekdays
  0 22 * * 1,3,5 # 10 PM on Monday, Wednesday, Friday
EOF
    
    echo -e "\nSpecial cron strings:"
    cat << 'EOF'
  @reboot       # Run once at startup
  @yearly       # Run once a year (0 0 1 1 *)
  @annually     # Same as @yearly
  @monthly      # Run once a month (0 0 1 * *)
  @weekly       # Run once a week (0 0 * * 0)
  @daily        # Run once a day (0 0 * * *)
  @midnight     # Same as @daily
  @hourly       # Run once an hour (0 * * * *)
EOF
}

demo_cron_basics

# =============================================================================
# CREATING AND MANAGING CRON JOBS
# =============================================================================

echo -e "\n=== CREATING AND MANAGING CRON JOBS ==="

demo_cron_management() {
    echo "Cron job management commands:"
    
    echo -e "\n1. View current cron jobs:"
    echo "   crontab -l"
    echo "   Current cron jobs for user $(whoami):"
    if crontab -l 2>/dev/null; then
        echo "   (Cron jobs listed above)"
    else
        echo "   No cron jobs found for current user"
    fi
    
    echo -e "\n2. Edit cron jobs:"
    echo "   crontab -e"
    echo "   (Opens default editor to modify cron jobs)"
    
    echo -e "\n3. Remove all cron jobs:"
    echo "   crontab -r"
    echo "   (Removes all cron jobs for current user)"
    
    echo -e "\n4. Install cron jobs from file:"
    echo "   crontab mycron.txt"
    
    # Create example cron file
    cat > example_cron.txt << 'EOF'
# Example cron jobs
# Backup database daily at 2 AM
0 2 * * * /home/user/scripts/backup_db.sh

# Clean temporary files every hour
0 * * * * /home/user/scripts/cleanup_temp.sh

# Send weekly report on Sundays at 9 AM
0 9 * * 0 /home/user/scripts/weekly_report.sh

# Monitor disk space every 15 minutes
*/15 * * * * /home/user/scripts/check_disk_space.sh
EOF
    
    echo -e "\n5. Example cron file (example_cron.txt):"
    cat example_cron.txt
    
    echo -e "\n6. System-wide cron jobs:"
    echo "   /etc/crontab - System cron table"
    echo "   /etc/cron.d/ - Additional cron files"
    echo "   /etc/cron.daily/ - Daily scripts"
    echo "   /etc/cron.hourly/ - Hourly scripts"
    echo "   /etc/cron.weekly/ - Weekly scripts"
    echo "   /etc/cron.monthly/ - Monthly scripts"
}

demo_cron_management

# =============================================================================
# WRITING SCRIPTS FOR SCHEDULED TASKS
# =============================================================================

echo -e "\n=== WRITING SCRIPTS FOR SCHEDULED TASKS ==="

# Create directory for example scripts
mkdir -p cron_scripts
cd cron_scripts

# Database backup script
create_backup_script() {
    cat > backup_database.sh << 'EOF'
#!/bin/bash
# =============================================================================
# DATABASE BACKUP SCRIPT
# =============================================================================

set -euo pipefail

# Configuration
BACKUP_DIR="/var/backups/database"
DB_NAME="myapp_db"
DB_USER="backup_user"
DB_HOST="localhost"
RETENTION_DAYS=7
LOG_FILE="/var/log/backup_database.log"

# Logging function
log_message() {
    echo "[$(date '+%Y-%m-%d %H:%M:%S')] $*" | tee -a "$LOG_FILE"
}

# Error handler
error_exit() {
    log_message "ERROR: $1"
    exit 1
}

# Main backup function
backup_database() {
    local timestamp=$(date +%Y%m%d_%H%M%S)
    local backup_file="$BACKUP_DIR/${DB_NAME}_${timestamp}.sql.gz"
    
    log_message "Starting database backup for $DB_NAME"
    
    # Create backup directory if it doesn't exist
    mkdir -p "$BACKUP_DIR" || error_exit "Failed to create backup directory"
    
    # Perform backup
    if mysqldump -h "$DB_HOST" -u "$DB_USER" -p"$DB_PASSWORD" "$DB_NAME" | gzip > "$backup_file"; then
        log_message "Backup completed successfully: $backup_file"
        
        # Verify backup file
        if [[ -s "$backup_file" ]]; then
            local size=$(du -h "$backup_file" | cut -f1)
            log_message "Backup file size: $size"
        else
            error_exit "Backup file is empty or missing"
        fi
    else
        error_exit "Database backup failed"
    fi
    
    # Clean up old backups
    cleanup_old_backups
}

# Cleanup old backups
cleanup_old_backups() {
    log_message "Cleaning up backups older than $RETENTION_DAYS days"
    
    find "$BACKUP_DIR" -name "${DB_NAME}_*.sql.gz" -mtime +$RETENTION_DAYS -delete
    
    local remaining=$(find "$BACKUP_DIR" -name "${DB_NAME}_*.sql.gz" | wc -l)
    log_message "Cleanup completed. $remaining backup files remaining"
}

# Check prerequisites
check_prerequisites() {
    # Check if mysqldump is available
    if ! command -v mysqldump >/dev/null 2>&1; then
        error_exit "mysqldump not found. Please install MySQL client"
    fi
    
    # Check if backup directory is writable
    if [[ ! -w "$(dirname "$BACKUP_DIR")" ]]; then
        error_exit "Cannot write to backup directory: $BACKUP_DIR"
    fi
    
    # Check if database password is set
    if [[ -z "${DB_PASSWORD:-}" ]]; then
        error_exit "DB_PASSWORD environment variable not set"
    fi
