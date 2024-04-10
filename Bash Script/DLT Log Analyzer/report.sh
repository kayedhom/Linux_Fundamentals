#!/bin/bash

# Function to report and trace error event count 
report_Errors(){
  if [[ ${#ERROR_MESSAGES[@]} -gt 0 ]]; then
    echo "** Errors:** A total of $ERROR_COUNTS errors were found."

  else
    echo "No errors detected."
  fi
}

# Function to report and trace warning event count 
report_Warnings(){
  if [[ ${#WARNING_MESSAGES[@]} -gt 0 ]]; then
    echo "** Warnings:** A total of $WARNING_COUNTS warnings were found."

  else
    echo "No warnings detected."
  fi
}

# Function to report and trace debugging event count 
report_Debugging(){
  if [[ ${#DEBUGGING_MESSAGES[@]} -gt 0 ]]; then
    echo "** Debug:** A total of $DEBUG_COUNTS debug events were found."

  else
    echo "No debug events detected."
  fi
}

# Function to report and trace info event count 
report_Info(){
  if [[ ${#INFO_MESSAGES[@]} -gt 0 ]]; then
    echo "** Info:** A total of $INFO_COUNTS info events were found."

  else
    echo "No info events detected."
  fi
}

# Report Error, Warning and System events review
report_summary() {
  echo "** Log Report Summary **"
  echo ""
	
	report_Errors
	report_Warnings
	report_Debugging
	report_Info
	report_System_Events_Tracing
}



report_issues() {
  # Error and Warning Trends
  echo "** Error and Warning Trends **"
  echo "---------------------------"
  	report_Errors
	report_Warnings
  
}

# Function to trace system events for configured system events
report_System_Events_Tracing() {
  # System Events
  echo ""
  echo "** System Events **"
  echo "------------------"
  # Track specific events using grep

  # Search for startup sequence initiation
  if grep -q "$startup_message" <<< "${log_entries[@]}"; then
    echo "** Startup Sequence:** Initiated successfully."
  else
    echo "** Startup Sequence:** Not found in logs."
  fi
  
  
  

  # Search for system health check
  if grep -q "$health_check_message" <<< "${log_entries[@]}"; then
    echo "** System Health Check:** Passed."
  else
    echo "** System Health Check:** Not found in logs."
  fi

  echo ""
}


# Function to create the report file and check for existence
create_report_file() {
  truncate -s 0 $report_file
  if [[ ! -f "$report_file" ]]; then
    touch "$report_file"  # Create the file if it doesn't exist
  fi


}


