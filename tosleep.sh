#! /bin/bash

# Function to check if a command exists
command_exists() {
    command -v "$@" > /dev/null 2>&1;
}

# Get the username
user="$(id -un 2>/dev/null || true)";

# Set the command for execution
sh_c='sh -c';

# If the user is not root, use sudo or su
if [ "$user" != 'root' ]; then
    if command_exists sudo; then
        sh_c='sudo -E sh -c';
    elif command_exists su; then
        sh_c='su -c';
    fi
fi

# Check if the rtcwake command exists
if command_exists rtcwake; then
    param='tomorrow';

    # Check command-line arguments
    if [ -n "$1" ]; then
        if [ "$1" == "help" ] || [ "$1" == "-h" ]; then
            # Help message
            echo "Available options:";
            echo "  -h, help       Show help";
            echo "  -d, day        Number of days to wake up again";
            echo "  -t, today      Wake up on the same day";
            exit 0;
        elif [ "$1" == "day" ] || [ "$1" == "-d" ]; then
            # Request the number of days to skip
            while true; do
                read -p "Number of days to skip: " day
                if [[ "$day" =~ ^[0-9]+$ ]]; then
                    param="$day days";
                    break;
                else
                    echo "Please, enter an integer.";
                fi
            done
        elif [ "$1" == "today" ] || [ "$1" == "-t" ]; then 
            param='today';
        fi
    fi
    
    # Loop to request the start time until the correct format is provided
    while true; do
        read -p "Time for the system to start (in HHMM format): " hour;
        if [[ "$hour" =~ ^[0-9]{4}$ ]]; then
            break;
        else
            echo "Please, enter the correct format (HHMM).";
        fi
    done

    # Execute the rtcwake command with the specified time
    $sh_c "rtcwake -m off -l -t \$(date +\%s -d \"$param $hour\")";
else 
    echo "rtcwake not found";
fi
