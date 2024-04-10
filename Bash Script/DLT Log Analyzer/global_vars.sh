#!/bin/bash


log_directory="."  # your log directory
    
# Initialize an empty array to store log entries
log_entries=()  

report_file="log_report.txt"
extraced_log_file="extraced_logs.log"
# Global arrays of keywords for each log level
declare -a ERROR_KEYWORDS=("error" "failed" "problem" "err" "denied" "unable" "failure")
declare -a WARNING_KEYWORDS=("warning" "alert" "warn" "cannot" "skipped" "not supported" "detected" "exceeds" "deprecated")
declare -a DEBUG_KEYWORDS=("debug" "starting" "running" "listening" "registering")

# Global variables of keywords for each system events
declare startup_message="System Startup Sequence Initiated"
declare health_check_message="System health check OK"

# Global counters for counting number of log levels
declare -i ERROR_COUNTS=0
declare -i WARNING_COUNTS=0
declare -i DEBUG_COUNTS=0

# Global arrays of messages for each log level
declare -a ERROR_MESSAGES=()
declare -a WARNING_MESSAGES=()
declare -a DEBUGGING_MESSAGES=()
declare -a INFO_MESSAGES=()



# Definitions
declare -i ERROR=0
declare -i WARNING=1
declare -i DEBUGGING=2
declare -i INFO=3
declare -i ALL_LOG_LEVELS=4
