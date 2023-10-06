# SJF Non-Preemptive 

#!/bin/bash

# # Define variables
# n=0
# arrival_time=()
# burst_time=()
# pid=()
# waiting_time=()
# tat=()
# head=0
# total_waiting_time=0

# # Get the number of processes
# echo -n "Enter the number of processes: "
# read n

# # Get the arrival time and burst time of each process
# for ((i=0; i<$n; i++)) do
#   echo -n "Enter Process Id: "
#   read pid[$i]
#   echo -n "Enter arrival time: "
#   read arrival_time[$i]
#   echo -n "Enter burst time: "
#   read burst_time[$i]
# done

# # Sort the processes according to their arrival time
# sort

# # Schedule the processes
# for ((i=0; i<$n; i++)) do
#   # Calculate the waiting time
#   waiting_time[i]=$((total_waiting_time))

#   # Calculate the turnaround time
#   tat[i]=$((waiting_time[i] + ${burst_time[$i]}))

#   # Update the total waiting time
#   total_waiting_time=$((total_waiting_time + ${burst_time[$i]}))

#   # Schedule the process
#   echo "Running process ${pid[$i]} from time ${arrival_time[$i]} to time ${tat[$i]}"
# done

# # Calculate the average waiting time and average turn around time
# avgwt=`echo "scale=3; $total_waiting_time / $n" | bc`
# avgtat=`echo "scale=3; $total_tat / $n" | bc`

# # Display the results
# echo -n "Average waiting time ="
# printf %.3f\\n "$avgwt"
# echo -n "Average turn around time ="
# printf %.3f\\n "$avgtat"

# ===========================================

#!/bin/bash

# Define a structure to represent a process
declare -A Process

# Function to calculate waiting time for each process
calculate_waiting_time() {
    local n=$1
    Process[0,waiting]=0

    for ((i = 1; i < n; i++)); do
        Process[$i,waiting]=0
        for ((j = 0; j < i; j++)); do
            Process[$i,waiting]=$((Process[$i,waiting] + ${Process[$j,burst]}))
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

# Sort processes by burst time
for ((i = 0; i < n; i++)); do
    for ((j = $i + 1; j < n; j++)); do
        if (( ${Process[$i,burst]} > ${Process[$j,burst]} )); then
            # Swap processes if they have different burst times
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
