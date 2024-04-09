#!/bin/bash


log_entries=()  # Initialize an empty array to store log entries


# Function to extract and print log information
print_log_info() {
    local log_file="$1"
    local pattern="^([A-Za-z]{3}\s+[0-9]{1,2}\s[0-9]{2}:[0-9]{2}:[0-9]{2})\s([^ ]+)\s(.*)$"

    while IFS= read -r line; do
        if [[ $line =~ $pattern ]]; then
            timestamp="${BASH_REMATCH[1]}"
            process="${BASH_REMATCH[2]}"
            message="${BASH_REMATCH[3]}"
           # hostname="${BASH_REMATCH[4]}"
            #echo "[$timestamp] $process: $message"
            log_entries+=( "[$timestamp] $process: $message $hostname" )  # Append formatted log entry to the array
        fi
    done < "$log_file"
}





# Main function to iterate over log files and print log information
main() {
    local log_directory="."  # Change this to your log directory
    local log_files=( "$log_directory"/*.log )

    for file in "${log_files[@]}"; do
        #echo "Logs for file: $file"
        print_log_info "$file"
    done
    printf '%s\n' "${log_entries[@]}"

}

# Run the main function
main
