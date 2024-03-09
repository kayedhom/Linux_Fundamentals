#!/bin/bash



# Function to get Cpu Percentage
Get_Cpu_Usage() {

	local pid_stat=($(sed -E 's/\([^)]+\)/X/' "/proc/$1/stat"))
        local utime=${pid_stat[13]}  # Time spent in user mode
        local stime=${pid_stat[14]}  # Time spent in system mode
        local starttime=${pid_stat[21]} # Time process started
        local total_time=$((utime + stime))		##Summation user and kernal process time
        local uptime_sec=$(tr . ' ' </proc/uptime | awk '{print $1}')	# Read system uptime from /proc/uptime file
        local uptime=$((uptime_sec*tick_time))	# only one in sec so convert it to ticks
	local process_elapsed_time=$((uptime - starttime))
	local process_cpu_pecentage=$((10000 * total_time / process_elapsed_time))
        echo "scale=2; $process_cpu_pecentage / 100" | bc
}

Get_Mem_Usage() {
	local pid_dir=$1
	local pid_mem_usage=$(awk '/VmRSS:/ {print $2}' "$pid_dir/status" 2>/dev/null)
	local total_mem=$(grep MemTotal /proc/meminfo | awk '{print $2}')
        local mem_percentage=$((pid_mem_usage * 10000 / total_mem))
        ##b=$(echo "scale=4; $a / 10000" | bc)
        echo "scale=2; $mem_percentage / 100" | bc
	##echo "$mem_percentage"

}

