#!/bin/bash


log_entries=()  # Initialize an empty array to store log entries




# Global arrays of keywords for each log level
declare -a ERROR_KEYWORDS=("error" "failed" "problem" "err" "denied" "unable" "failure")
declare -a WARNING_KEYWORDS=("warning" "alert" "warn" "cannot" "skipped" "not supported" "detected" "exceeds" "deprecated")
declare -a DEBUG_KEYWORDS=("debug" "starting" "running" "listening" "registering")


# Function to extract and print log information
extract_log_info() {
    local log_file="$1"
    local pattern="^([A-Za-z]{3}\s+[0-9]{1,2}\s[0-9]{2}:[0-9]{2}:[0-9]{2})\s([^ ]+)\s(.*)$"

    while IFS= read -r line; do
        if [[ $line =~ $pattern ]]; then
            timestamp="${BASH_REMATCH[1]}"
            #process="${BASH_REMATCH[2]}"
            #message="${BASH_REMATCH[3]}" 
            
            #Replace every "all_Char: " with nothing so it is /empty/
 	     message=$(echo "${BASH_REMATCH[3]}" | sed 's/.*: //')
 	     log_level="$(check_log_level "$message")"
            # Convert and format timestamp
            formatted_timestamp=$(convert_timestamp_format "$timestamp")

            # Append formatted log entry to the array
            #log_entries+=( "$formatted_timestamp $process: $message" )
            log_entries+=( "$formatted_timestamp $log_level $message" )
        fi
    done < "$log_file"
}


# Function to convert timestamp format
convert_timestamp_format() {
    local old_timestamp="$1"
    local month="${old_timestamp:0:3}"  # Extract month abbreviation
    local day="${old_timestamp:4:2}"    # Extract day
    local time="${old_timestamp:7:8}"   # Extract time
    local year="$(date +'%y')"          # Get the current year

    # Convert month abbreviation to numeric value
    month=$(convert_month_format "$month")

    # Format timestamp in the desired format
    local new_timestamp="[20${year}-${month}-${day} ${time}]"
    echo "$new_timestamp"
}


# Function to check the log level based on keywords in the message
check_log_level() {
    local message="$1"
    
    #make it all lower case to avoid non-monocase words(Error, eRRor)
    local message_lower=$(echo "$message" | tr '[:upper:]' '[:lower:]')
    local log_level="INFO"  # Default log level is INFO
    
    # Loop through ERROR keywords
    for keyword in "${ERROR_KEYWORDS[@]}"; do
        if [[ $message_lower =~ "$keyword" ]]; then
            log_level="ERROR"
            break
        fi
    done
    
    # If log level is still INFO, loop through WARNING keywords
    if [[ $log_level == "INFO" ]]; then
        for keyword in "${WARNING_KEYWORDS[@]}"; do
            if [[ $message_lower =~ "$keyword" ]]; then
                log_level="WARNING"
                break
            fi
        done
    fi
    
    # If log level is still INFO, loop through DEBUG keywords
    if [[ $log_level == "INFO" ]]; then
        for keyword in "${DEBUG_KEYWORDS[@]}"; do
            if [[ $message_lower =~ "$keyword" ]]; then
                log_level="DEBUG"
                break
            fi
        done
    fi
    
    echo "$log_level"
}

# Function to convert month format
convert_month_format() {

	local month="$1"
	
 	# Convert month abbreviation to numeric value
	    case $month in
		"Jan") month="01" ;;
		"Feb") month="02" ;;
		"Mar") month="03" ;;
		"Apr") month="04" ;;
		"May") month="05" ;;
		"Jun") month="06" ;;
		"Jul") month="07" ;;
		"Aug") month="08" ;;
		"Sep") month="09" ;;
		"Oct") month="10" ;;
		"Nov") month="11" ;;
		"Dec") month="12" ;;
	    esac
	
	echo "$month"

}

# Main function to iterate over log files and print log information
main() {
    local log_directory="."  # your log directory
    local log_files=( "$log_directory"/*.log )

    for file in "${log_files[@]}"; do
        #echo "Logs for file: $file"
        extract_log_info "$file"
    done
    printf '%s\n' "${log_entries[@]}"

}

# Run the main function
main
