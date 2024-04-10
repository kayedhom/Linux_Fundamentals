#!/bin/bash

# Function to check the log level based on keywords in the message
DLT_check_log_level() {
    local message="$1"
    
    #make it all lower case to avoid non-monocase words(Error, eRRor)
    local message_lower=$(echo "$message" | tr '[:upper:]' '[:lower:]')
    local log_level="INFO"  # Default log level is INFO
    
    #Check message if error
    log_level=$(DLT_check_error "$message_lower" "$log_level")
    
    # If log level is still INFO, loop through WARNING keywords
    
    if [[ $log_level == "INFO" ]]; then
    #Check message if warning
    log_level=$(DLT_check_warning "$message_lower" "$log_level")
    fi
    
    # If log level is still INFO, loop through DEBUG keywords
    
    if [[ $log_level == "INFO" ]]; then
    #Check message if debug
    log_level=$(DLT_check_dubug "$message_lower" "$log_level")
    fi
    
    echo "$log_level"
}


# Function to check errors
DLT_check_error(){
    local message="$1"
    local log_level="$2"
    
    # Loop through ERROR keywords
    for keyword in "${ERROR_KEYWORDS[@]}"; do
        if [[ $message =~ "$keyword" ]]; then
            log_level="ERROR"
            break
        fi
    done
    
    echo "$log_level"
}


# Function to check warnings
DLT_check_warning(){
    local message="$1"
    local log_level="$2"  
    
    # Loop through WARNING keywords
    for keyword in "${WARNING_KEYWORDS[@]}"; do
        if [[ $message =~ "$keyword" ]]; then
            log_level="WARNING"
            break
        fi
    done
    
    echo "$log_level"
}


# Function to check debugs
DLT_check_debug(){
    local message="$1"
    local log_level="$2"  
    
    # Loop through DEBUG keywords
    for keyword in "${DEBUG_KEYWORDS[@]}"; do
        if [[ $message =~ "$keyword" ]]; then
            log_level="DEBUG"
            break
        fi
    done
    
    echo "$log_level"
}

