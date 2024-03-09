#!/bin/bash

config_file="Config_sets.txt"

# Function to update configuration values in the file
update_configuration() {
    local config_file="$1"
    local var_name="$2"
    local new_value="$3"
    
    sed -i "s/^$var_name=.*/$var_name=$new_value/" "$config_file"


	# Delete the original file
	rm "$config_file"

	# Create a new file with updated content
	echo "# Configuration variables" >> "$config_file"
	echo "MEM_MIN=$MEM_MIN" >> "$config_file"
	echo "MEM_MAX=$MEM_MAX" >> "$config_file"
	echo "CPU_MIN=$CPU_MIN" >> "$config_file"
	echo "CPU_MAX=$CPU_MAX" >> "$config_file"
	echo "REFRESH_TIME=$REFRESH_TIME" >> "$config_file"

}



# Function to change configuration with input validation
Change_Config() {
    local option=$1
    ##Set default values
    local new_REFRESH_TIME=$REFRESH_TIME
    local new_CPU_MIN=$CPU_MIN
    local new_CPU_MAX=$CPU_MAX
    local new_MEM_MIN=$MEM_MIN
    local new_MEM_MAX=$MEM_MAX

    case $option in
        A)
            read -p "Enter new refresh rate in seconds: " new_REFRESH_TIME
            ;;
        B)
            read -p "Enter new minimum CPU usage limit: " new_CPU_MIN
            ;;
        C)
            read -p "Enter new maximum CPU usage limit: " new_CPU_MAX
            ;;
        D)
            read -p "Enter new minimum memory usage limit: " new_MEM_MIN
            ;;
        E)
            read -p "Enter new maximum memory usage limit: " new_MEM_MAX
            ;;
        *)
            echo "Invalid option."
            return
            ;;
    esac

    # Validate input
    local valid=true
    local error_message=""

    if ! [[ "$new_REFRESH_TIME" =~ ^[1-9][0-9]*$ ]]; then
        valid=false
        error_message+="Refresh rate must be a positive integer.\n"
    fi

    if (( $(bc <<< "$new_CPU_MIN < 0 || $new_CPU_MIN > 100" 2>/dev/null) )); then
        valid=false
        error_message+="Minimum CPU usage limit must be between 0 and 100.\n"
    fi

    if (( $(bc <<< "$new_CPU_MAX < 0 || $new_CPU_MAX > 100" 2>/dev/null) )); then
        valid=false
        error_message+="Maximum CPU usage limit must be between 0 and 100.\n"
    fi

    if (( $(bc <<< "$new_MEM_MIN < 0 || $new_MEM_MIN > 100" 2>/dev/null) )); then
        valid=false
        error_message+="Minimum memory usage limit must be between 0 and 100.\n"
    fi

    if (( $(bc <<< "$new_MEM_MAX < 0 || $new_MEM_MAX > 100" 2>/dev/null) )); then
        valid=false
        error_message+="Maximum memory usage limit must be between 0 and 100.\n"
    fi

    if (( $(echo "$new_CPU_MIN >= $new_CPU_MAX" | bc -l) )); then
        valid=false
        error_message+="Minimum CPU usage limit must be smaller than maximum CPU usage limit.\n"
    fi

    if (( $(echo "$new_MEM_MIN >= $new_MEM_MAX" | bc -l) )); then
        valid=false
        error_message+="Minimum memory usage limit must be smaller than maximum memory usage limit.\n"
    fi

    if ! $valid; then
        echo -e "Changes not applied. Please correct the following errors:\n$error_message"
        return
    fi

    # Apply changes
    case $option in
        A)
         REFRESH_TIME=$new_REFRESH_TIME
         log_configuration_change "Refresh rate changed to $new_REFRESH_TIME seconds" 
         update_configuration "$config_file" "$REFRESH_TIME" "$new_REFRESH_TIME"
         ;;

        B) 
        CPU_MIN=$new_CPU_MIN 
        log_configuration_change "Minimum CPU usage limit changed to $new_CPU_MIN%"
        update_configuration "$config_file" "$CPU_MIN" "$new_CPU_MIN"
        ;;
        
        C) 
        CPU_MAX=$new_CPU_MAX 
        log_configuration_change "Maximum CPU usage limit changed to $new_CPU_MAX%"
        update_configuration "$config_file" "$CPU_MAX" "$new_CPU_MAX"
        ;;
        
        D) 
        MEM_MIN=$new_MEM_MIN 
        log_configuration_change "Minimum memory usage limit changed to $new_MEM_MIN%"
        update_configuration "$config_file" "$MEM_MIN" "$new_MEM_MIN"
        ;;
        
        E) 
        MEM_MAX=$new_MEM_MAX
        log_configuration_change "Maximum memory usage limit changed to $new_MEM_MAX%"
        update_configuration "$config_file" "$MEM_MAX" "$new_MEM_MAX"
        ;;
        
    esac
    echo -e "\n Changes applied successfully. \n"
}


Config_Print(){
        echo -e "Refresh Rate Display System statistics $REFRESH_TIME sec."
        echo -e "Minimum Cpu Usage Filtration--> $CPU_MIN% ."
        echo -e "Maximum Cpu Usage Filtration--> $CPU_MAX% ."
        echo -e "Minimum Memory Usage Filtration--> $MEM_MIN% ."
        echo -e "Maximum Memory Usage Filtration--> $MEM_MAX% .\n\n"
}

Config_Print_Animation() {
    clear  # Clear the screen

    # Define animation frames
    frames=("|    " "/    " "-    " "\\    ")

    # Print animation frames
    for ((i = 0; i < 2; i++)); do
        for frame in "${frames[@]}"; do
            printf "\r%s [frame] Refresh Rate Display System statistics $REFRESH_TIME sec." "$frame"
            sleep 0.1  # Adjust sleep duration for animation speed
        done
    done

    # Print configuration information in a table format
    printf "\r%-10s %-10s %-10s %-10s %-10s\n" "Parameter" "Min" "Max" "Condition" "Result"
    printf "%-10s %-10s %-10s %-10s %-10s\n" "CPU Usage" "$CPU_MIN%" "$CPU_MAX%" "0 <= CPU_MIN < CPU_MAX <= 100" ""
    printf "%-10s %-10s %-10s %-10s %-10s\n" "Memory Usage" "$MEM_MIN%" "$MEM_MAX%" "0 <= MEM_MIN < MEM_MAX <= 100" ""
    
    printf "\n\n\r%s Refresh Rate Display System statistics $REFRESH_TIME sec."

    echo -e "\n\n"
}



Config_Set(){
	while true; do
	Config_Print
	 echo "Choose Config you want change"
	 echo "1. Refresh Rate Display System statistics in sec."
	 echo "2. Cpu Usage Min Limits"
	 echo "3. Cpu Usage Max Limits"
	 echo "4. Memory Min Usage Limits"
	 echo "5. Memory Max Usage Limits"
	 echo "6. Back to Main"
	 read -p "Enter your choice: " choice_search_filter
	 echo -e "\n"
	 
	 case $choice_search_filter in
          1) Change_Config "A" ;;
          1) Change_Config "B" ;;
	  3) Change_Config "C" ;;
	  4) Change_Config "D" ;;
	  5) Change_Config "E";;
          6) echo "Exiting."; break ;; 
	  *) echo -e "Invalid choice. Please try again.\n\n" ;;
    	esac
    	
	done
}

Configuration(){

	while true; do
	 echo "Configuration Options"
	 echo "1. Change Configurations"
	 echo "2. Display Configurations"
	 echo "3.Back to Main"
	 read -p "Enter your choice: " choice_search_filter
	 echo -e "\n"
	
	case $choice_search_filter in
	  1) Config_Set;;
	  2) Config_Print_Animation;;
          3) echo "Exiting."; break ;; 
	  *) echo -e "Invalid choice. Please try again.\n\n" ;;
    	esac
    done
}

