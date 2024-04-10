#!/bin/bash

source global_vars.sh
source check.sh
source report.sh




# Function to extract and print log information
DLT_extract_log_info() {
    local log_file="$1"
    local pattern="^([A-Za-z]{3}\s+[0-9]{1,2}\s[0-9]{2}:[0-9]{2}:[0-9]{2})\s([^ ]+)\s(.*)$"

    while IFS= read -r line; do
        if [[ $line =~ $pattern ]]; then
            timestamp="${BASH_REMATCH[1]}"
            
            #Replace every "all_Char: " with nothing so it is /empty/
 	    message=$(echo "${BASH_REMATCH[3]}" | sed 's/.*: //')
 	    log_level="$(DLT_check_log_level "$message")"
            
            # Convert and format timestamp
            formatted_timestamp=$(DLT_convert_timestamp_format "$timestamp")

            # Append formatted log entry to the array
            log_entries+=( "$formatted_timestamp $log_level $message" )
            
            DLT_count_log_levels "$formatted_timestamp" "$log_level" "$message"
        fi
    done < "$log_file"
}


# Function to convert timestamp format
DLT_convert_timestamp_format() {
    local old_timestamp="$1"
    local month="${old_timestamp:0:3}"  # Extract month abbreviation
    local day="${old_timestamp:4:2}"    # Extract day
    local time="${old_timestamp:7:8}"   # Extract time
    local year="$(date +'%y')"          # Get the current year

    # Convert month abbreviation to numeric value
    month=$(DLT_convert_month_format "$month")

    # Format timestamp in the desired format
    local new_timestamp="[20${year}-${month}-${day} ${time}]"
    echo "$new_timestamp"
}


# Function to convert month format
DLT_convert_month_format() {

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




DLT_count_log_levels(){
      local timestamp="$1"
      local log_level="$2"
      local message="$3"

      case $log_level in
        "ERROR")
          ((ERROR_COUNTS++))
          ERROR_MESSAGES+=("$timestamp $log_level  $message")
          ;;
        "WARNING")
          ((WARNING_COUNTS++))
          WARNING_MESSAGES+=("$timestamp $log_level  $message")
          ;;
        "DEBUG")
          ((DEBUG_COUNTS++))
          DEBUGGING_MESSAGES+=("$timestamp $log_level  $message")
          ;;
        *)
          ((INFO_COUNTS++))
          INFO_MESSAGES+=("$timestamp $log_level  $message")
          ;;
      esac
}


# Main function to iterate over log files and print log information
DLT_log_iteration() {
    local log_files=( "$log_directory"/*.log )

    for file in "${log_files[@]}"; do
        #echo "Logs for file: $file"
        DLT_extract_log_info "$file"
    done
}


# Function to print logs of selected log level type
DLT_print_logs(){
	local option="$1"
	
	if [ "$option" = "$ALL_LOG_LEVELS" ]; then
	 printf '%s\n' "${log_entries[@]}"
	 
	elif [ "$option" = "$ERROR" ]; then
	 printf '%s\n' "${ERROR_MESSAGES[@]}"
	 
	elif [ "$option" = "$WARNING" ]; then
	 printf '%s\n' "${WARNING_MESSAGES[@]}"
	 
	elif [ "$option" = "$DEBUGGING" ]; then
	 printf '%s\n' "${DEBUGGING_MESSAGES[@]}"
	 
	elif [ "$option" = "$INFO" ]; then
	 printf '%s\n' "${INFO_MESSAGES[@]}"
	 	 	 	 
	fi

}







# Function to display filter options for users to select a log level messages type
DLT_Filtering_By_Type(){

while true; do
    echo "Select a log level"
    echo "1. Display Error logs"
    echo "2. Display Warning logs"
    echo "3. Display Debuging logs"
    echo "4. Display Info logs"
    echo "5. Back to Main"
    read -p "Enter your choice: " choice
    echo -e "\n"
    
    case $choice in
        1) DLT_print_logs "$ERROR" ;;
        2) DLT_print_logs "$WARNING" ;;
        3) DLT_print_logs "$DEBUGGING";;
        4) DLT_print_logs "$INFO";;
        5) echo "Back to Main."; break ;; 
        *) echo "Invalid choice. Please try again." ;;
    esac
done
}

main(){

DLT_log_iteration
truncate -s 0 $extraced_log_file
DLT_print_logs "$ALL_LOG_LEVELS" >> "$extraced_log_file"

while true; do
    echo ""
    echo "DLT Log Analyzer"
    echo "1. Display System logs"
    echo "2. Filtering by log level"
    echo "3. Error and Warning Summary"
    echo "4. Summarized Report"
    echo "5. Exit"
    read -p "Enter your choice: " choice
    echo -e "\n"
    
    case $choice in
        1) DLT_print_logs "$ALL_LOG_LEVELS" ;;
        2) DLT_Filtering_By_Type ;;
        3) report_issues;;
        4) 
        report_summary
        create_report_file
	report_summary >> "$report_file"
        ;;
        5) echo "Exiting."; break ;; 
        *) echo "Invalid choice. Please try again." ;;
    esac
done
}

# Run the main function
main
