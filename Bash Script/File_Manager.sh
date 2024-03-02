#!/bin/bash

# Function to organize files in a directory
main() {
    local directory="$1"
    local This_File_Name=$BASH_SOURCE

    # Check if directory exists
    if [ ! -d "$directory" ]; then
        echo "Error: Directory '$directory' does not exist."
        return 1
    fi

    # Declare an array to store file names
    declare -a files_array

    # Populate files_array with the output of find command, excluding the script file
    mapfile -t files_array < <(find "$directory" -maxdepth 1 -type f -not -name "$(basename "$This_File_Name")" -print)

    # Declare directory paths for different file types
    local text_dir="$directory/text_files"
    local pdf_dir="$directory/pdf_files"
    local jpg_dir="$directory/jpg_files"
    local sh_dir="$directory/sh_files"
    local misc_dir="$directory/misc_files"

    # Create subdirectories if they don't exist
    mkdir -p "$text_dir" "$pdf_dir" "$jpg_dir" "$misc_dir" "$sh_dir"

    # Loop through files_array
    for file in "${files_array[@]}"; do
        if [[ $file == *.txt ]]; then
            mv_file "$file" "$text_dir"
        elif [[ $file == *.pdf ]]; then
            mv_file "$file" "$pdf_dir"
        elif [[ $file == *.jpg ]]; then
            mv_file "$file" "$jpg_dir"
        elif [[ $file == *.sh ]]; then
            mv_file "$file" "$sh_dir"
        elif [[ $file != *.* ]]; then
            mv_file "$file" "$misc_dir"
        fi
    done
    
declare -a Other_files_array
    
# Populate files_array with the output of find command, excluding the script file
mapfile -t Other_files_array < <(find "$directory" -maxdepth 1 -type f -not -name "$(basename "$This_File_Name")" -print)

    for file in "${Other_files_array[@]}"; do
     if [ -f "$file" ]; then
  	# Move a file with no extension to the misc directory
            mv_file "$file" "$misc_dir"
     else
	echo "Error: Failed to move '$file' to '$misc_dir'"
     fi
done

    # Declare an array to store remaining files' names
    declare -a other_files_array

    # Populate other_files_array with the output of find command, excluding the script file
    mapfile -t other_files_array < <(find "$directory" -maxdepth 1 -type f -not -name "$(basename "$BASH_SOURCE")" -print)

    # Move files with no extension to the misc directory
    for file in "${other_files_array[@]}"; do
        if [ -f "$file" ]; then
            mv_file "$file" "$misc_dir"
        fi
    done

    echo "Files Organization is completed."
}

# Function to move file to directory
mv_file() {
    local file="$1"
    local destination="$2"
    local fileNAME=$(basename "$file")
    mv "$file" "$destination"
    if [ $? -eq 0 ]; then
        echo "|-- $(basename "$destination")/"
        echo "|   |--" "$fileNAME" "to" "$destination"
    else
        echo "Error: Failed to move '$file' to '$destination'"
    fi
}

# Check if directory path argument is provided
if [ $# -eq 0 ]; then
    directory="$PWD"
else
    # Directory path argument
    directory="$1"
fi

# Call the main function with the specified directory
main "$directory"
