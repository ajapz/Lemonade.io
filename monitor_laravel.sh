#!/bin/bash

# Define the service name
SERVICE_NAME="laravel-backend.service"

# Define the CPU usage threshold (80%)
CPU_THRESHOLD=80

# Get the current CPU usage percentage for the Laravel backend process
CPU_USAGE=$(top -bn1 | grep "php" | awk '{print $9}' | awk -F. '{print $1}' | head -n 1)

# Check if CPU usage exceeds the threshold
if [ "$CPU_USAGE" -gt "$CPU_THRESHOLD" ]; then
    echo "CPU usage is at $CPU_USAGE%, which is above the threshold of $CPU_THRESHOLD%. Restarting $SERVICE_NAME..."
    
    # Restart the Laravel backend service
    systemctl restart $SERVICE_NAME
    
    if [ $? -eq 0 ]; then
        echo "$SERVICE_NAME restarted successfully."
    else
        echo "Failed to restart $SERVICE_NAME."
    fi
else
    echo "CPU usage is at $CPU_USAGE%, which is within the acceptable range."
fi
