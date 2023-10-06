# Round Robin Program

#!/bin/bash

# Define a structure to represent a process
declare -A Process

# Function to execute processes using Round Robin
round_robin() {
    local n=$1
    local quantum=$2
    local remaining_burst=()

    # Initialize remaining burst times and completed flags
    for ((i = 0; i < n; i++)); do
        remaining_burst[$i]=${Process[$i,burst]}
        completed[$i]=0
    done

    local current_time=0

    while true; do
        local all_completed=1

        for ((i = 0; i < n; i++)); do
            if (( ${Process[$i,arrival]} <= current_time )) && (( ${remaining_burst[$i]} > 0 )); then
                all_completed=0

                if (( ${remaining_burst[$i]} > quantum )); then
                    current_time=$((current_time + quantum))
                    remaining_burst[$i]=$((remaining_burst[$i] - quantum))
                else
                    current_time=$((current_time + remaining_burst[$i]))
                    Process[$i,completion]=$current_time
                    remaining_burst[$i]=0
                    completed[$i]=1
                fi
            fi
        done

        if ((all_completed)); then
            break
        fi
    done
}

# Function to calculate waiting time for each process
calculate_waiting_time() {
    local n=$1

    for ((i = 0; i < n; i++)); do
        Process[$i,waiting]=$((Process[$i,completion] - ${Process[$i,arrival]} - ${Process[$i,burst]}))
    done
}

# Function to calculate turnaround time for each process
calculate_turnaround_time() {
    local n=$1

    for ((i = 0; i < n; i++)); do
        Process[$i,turnaround]=$((Process[$i,completion] - ${Process[$i,arrival]}))
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
    Process[$i,completion]=0
done

echo "Enter the time quantum:"
read quantum

round_robin $n $quantum
calculate_waiting_time $n
calculate_turnaround_time $n

# Display the process scheduling results
echo "Process   Arrival Time   Burst Time   Waiting Time   Turnaround Time"
for ((i = 0; i < n; i++)); do
    echo "$i         ${Process[$i,arrival]}                ${Process[$i,burst]}                ${Process[$i,waiting]}                  ${Process[$i,turnaround]}"
done
