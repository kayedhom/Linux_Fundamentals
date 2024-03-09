#!/bin/bash

# Function to display process information
display_processes() {
    clear  # Clear the screen
    printf "%-10s %-10s %-10s %-10s %-10s %s\n" "USER" "PPID" "PID" "CPU %" "MEM %"
        Option_here="$1"
        User_search_filter="$2"
    for pid_dir in /proc/[0-9]*; do
        pid=$(basename "$pid_dir")
        ##Assign all pids in array for further usage
        all_pids+=("$pid")
        ppid=$(awk '/PPid:/ {print $2}' "$pid_dir/status" 2>/dev/null)
        ##checks if the variable ppid is not empty,process directory does not correspond to a running process
        if [ -n "$ppid" ]; then
            cpu=$(Get_Cpu_Usage "$pid")
            mem=$(Get_Mem_Usage "$pid_dir")
            if (( $(echo "$mem < 0.10" | bc) )); then
              continue
            fi
            command=$(tr -d '\0' < "$pid_dir/cmdline" 2>/dev/null)
            # Get the username associated with the process
            proc_user=$(awk '$1 == "Uid:" {print $2}' "$pid_dir/status" 2>/dev/null)
            # Convert UID to username
            proc_username=$(getent passwd "$proc_user" | cut -d: -f1)

            # Option B: Print only for user of $USER_SEARCH
            if [ "$Option_here" = "B" ]; then
		if [ "$proc_username" != "$User_search_filter" ]; then
		##Mismatch username
                    continue
		fi
            fi
            # Option C: Print only for process memory usage between ($MEM_MIN & $MEM_MAX)
            if [ "$1" = "C" ]; then
                if (( $(echo "$mem < $MEM_MIN || $mem > $MEM_MAX" | bc -l) )); then
                    continue
                fi
            fi
            # Option D: Print only for process cpu usage between ($CPU_MIN & $CPU_MAX)
            if [ "$1" = "D" ]; then
                if (( $cpu < $CPU_MIN || $cpu > $CPU_MAX )); then
                    continue
                fi
            fi
            
            printf "%-10s %-10s %-10s %-10s %-10s %s\n" "$proc_username" "$ppid" "$pid" "$cpu" "$mem"

        fi
    done
       if [ "$Option_here" = "A" ]; then
        sleep REFRESH_TIME  # Wait for 15 seconds before refreshing
        display_processes
       fi
}

