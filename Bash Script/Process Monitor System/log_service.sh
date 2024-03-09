#!/bin/bash


# Function to log configuration changes
log_configuration_change() {
    local log_file="process_monitor.log"
    local timestamp=$(date +"%Y-%m-%d %H:%M:%S")
    local change="$1"

    echo "$timestamp - Configuration change: $change" >> "$log_file"
}

# Function to log process-related activities
log_activity() {
    local log_file="process_monitor.log"
    local timestamp=$(date +"%Y-%m-%d %H:%M:%S")
    local activity="$1"

    echo "$timestamp - $activity" >> "$log_file"
}

# Function to log process termination
log_process_termination() {
    local pid="$1"
    local process_info=$(ps -p "$pid" -o user=,pid=,ppid=,pcpu=,%mem=,comm= --no-header)

    log_activity "Process with PID $pid terminated: $process_info"
}
