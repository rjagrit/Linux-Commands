# SRTF Preemitive algo

#!/bin/bash

# Define a structure to represent a process
declare -A Process

# Function to calculate the waiting time for each process
calculate_waiting_time() {
    local n=$1
    local remaining_burst=()
    local completion_time=0

    # Initialize remaining burst times
    for ((i = 0; i < n; i++)); do
        remaining_burst[$i]=${Process[$i,burst]}
    done

    while true; do
        local min_burst=999999
        local shortest_process=-1
        local flag=0

        # Find the process with the shortest remaining burst time
        for ((i = 0; i < n; i++)); do
            if (( ${Process[$i,arrival]} <= completion_time )) && (( ${remaining_burst[$i]} < min_burst )) && (( ${remaining_burst[$i]} > 0 )); then
                min_burst=${remaining_burst[$i]}
                shortest_process=$i
                flag=1
            fi
        done

        # If no process is found, break the loop
        if ((flag == 0)); then
            break
        fi

        # Reduce the remaining burst time of the selected process
        remaining_burst[$shortest_process]=$((remaining_burst[$shortest_process] - 1))

        # Update the completion time
        completion_time=$((completion_time + 1))

        # Update waiting time for all processes
        for ((i = 0; i < n; i++)); do
            if (( ${Process[$i,arrival]} <= completion_time )) && (( $i != $shortest_process )); then
                Process[$i,waiting]=$((Process[$i,waiting] + 1))
            fi
        done
    done
}

# Function to calculate turnaround time for each process
calculate_turnaround_time() {
    local n=$1

    for ((i = 0; i < n; i++)); do
        Process[$i,turnaround]=$((Process[$i,waiting] + ${Process[$i,burst]}))
    done
}

# Main program
echo "Enter the number of processes:"
read n

# Initialize process data
for ((i = 0; i < n; i++)); do
    echo "Enter arrival time for process $i:"
    read Process[$i,arrival]
    echo "Enter burst time for process $i:"
    read Process[$i,burst]
    Process[$i,waiting]=0
    Process[$i,turnaround]=0
done

# Sort processes by arrival time
for ((i = 0; i < n; i++)); do
    for ((j = $i + 1; j < n; j++)); do
        if (( ${Process[$i,arrival]} > ${Process[$j,arrival]} )); then
            # Swap processes if they arrive out of order
            temp=${Process[$i,arrival]}
            Process[$i,arrival]=${Process[$j,arrival]}
            Process[$j,arrival]=$temp

            temp=${Process[$i,burst]}
            Process[$i,burst]=${Process[$j,burst]}
            Process[$j,burst]=$temp
        fi
    done
done

calculate_waiting_time $n
calculate_turnaround_time $n

# Display the process scheduling results
echo "Process   Arrival Time   Burst Time   Waiting Time   Turnaround Time"
for ((i = 0; i < n; i++)); do
    echo "$i         ${Process[$i,arrival]}                ${Process[$i,burst]}                ${Process[$i,waiting]}                  ${Process[$i,turnaround]}"
done
