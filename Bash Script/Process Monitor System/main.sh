#!/bin/bash




##Global Var.
declare -a all_pids=()
tick_time=$(getconf CLK_TCK)


source Config_sets.txt
source Config_Editing.sh
source log_service.sh
source mem_cpu_usage.sh
source Monitor_Processes.sh
source Search_services.sh




Check_By_Resource(){
	while true; do
	 echo "Check By Resource Usages"
	 echo "1. Memory Usage Limits"
	 echo "2. Cpu Usage Limits"
	 echo "3. Change Configurations"
	 echo "4. Check Configurations"
	 echo "5.Back to Main"
	 read -p "Enter your choice: " choice_search_filter
	 echo -e "\n"
	
	case $choice_search_filter in
          1) display_processes "C" ;;
          2) display_processes "D" ;;
	  3) Config_Set;;
	  4) Config_Print_Animation;;
          5) echo "Exiting."; break ;; 
	  *) echo -e "Invalid choice. Please try again.\n\n" ;;
    	esac
    done

}

Check_By_User(){
 	 read -p "Enter User name or ID : " choice_search_filter
 	 ##Check if user exist!!
 	 if user_exists "$choice_search_filter"; then
		option=B
		display_processes $option $choice_search_filter
	else
	    echo -e "User does not exist.Try again! \n\n"
	fi
}


##Search and Filter
Search_Filter_Menu(){
	while true; do
	 echo "Search & Filtering"
	 echo "1. Check Process ID exists?"
	 echo "2. Check by User"
	 echo "3. Check by resource usage"
	 echo "4.Kill Process"
	 echo "5.Back to Main"
	 read -p "Enter your choice: " choice_search_filter
	 echo -e "\n"
	
	case $choice_search_filter in
	  1) PID_Search ;;
	  2) Check_By_User ;;
	  3) Check_By_Resource;;
	  4) Kill_Process;;
	  5) echo "Exiting."; break ;; 
	  *) echo -e "Invalid choice. Please try again.\n\n" ;;
    	esac
    done
}



# Main menu
while true; do
    echo "Process Monitor"
    echo "1. Display System Process statistics"
    echo "2. Search or Filter"
    echo "3. Configuration Options"
    echo "4. Kill a Process"
    echo "5. Exit"
    read -p "Enter your choice: " choice
    echo -e "\n"
    
    case $choice in
        1) display_processes "A" ;;
        2) Search_Filter_Menu ;;
        3) Configuration;;
        4) Kill_Process;;
        5) echo "Exiting."; break ;; 
        *) echo "Invalid choice. Please try again." ;;
    esac
done

