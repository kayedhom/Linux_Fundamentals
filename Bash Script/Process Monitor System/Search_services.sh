#!/bin/bash



# Function to check if PID exists in all_pids array
PID_Exists() {
    local pid_to_check="$1"
    local found=false

    # Iterate over the all_pids array
    for stored_pid in "${all_pids[@]}"; do
        if [ "$stored_pid" = "$pid_to_check" ]; then
            found=true
            break
        fi
    done

    echo "$found"
}


# Function to check if a user exists
user_exists() {
    local username="$1"
    if getent passwd "$username" >/dev/null 2>&1; then
        return 0  # User exists
    else
        return 1  # User does not exist
    fi
}



## Process Search by ID
PID_Search() {
    read -p "Enter The Process ID: " PID
    found=$(PID_Exists "$PID")

    if [ "$found" = true ]; then
        echo -e "Process ID $PID found in the system.\n"
        sleep 1
    else
        echo -e "Process ID $PID -not- found in the system.\n"
        sleep 1
    fi
}




## Kill Process by ID
Kill_Process() {
    read -p "Enter The Process ID to kill: " PID
    found=$(PID_Exists "$PID")

    if [ "$found" = true ]; then
        # Kill the process
        kill "$PID"
        echo -e "Process ID $PID has been killed.\n"
        sleep 1
    else
        echo -e "Process ID $PID -not- found in the system.\n"
        sleep 1
    fi
    
    log_process_termination "$PID"

}


