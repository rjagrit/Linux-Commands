# FCFS CPU Scheduling

#!/bin/bash

# Define the number of processes
num_processes=4

# Initialize arrays for process arrival time, burst time, and waiting time
arrival_time=(0 1 2 3)
burst_time=(8 4 1 3)
waiting_time=()

# Calculate waiting time for each process
waiting_time[0]=0  # The first process has a waiting time of 0

for ((i=1; i<$num_processes; i++)); do
    waiting_time[$i]=$((waiting_time[$(($i-1))] + burst_time[$(($i-1))]))
done

# Calculate turnaround time for each process
turnaround_time=()
for ((i=0; i<$num_processes; i++)); do
    turnaround_time[$i]=$((waiting_time[$i] + burst_time[$i]))
done

# Calculate average waiting time and average turnaround time
total_waiting_time=0
total_turnaround_time=0

for ((i=0; i<$num_processes; i++)); do
    total_waiting_time=$((total_waiting_time + waiting_time[$i]))
    total_turnaround_time=$((total_turnaround_time + turnaround_time[$i]))
done

avg_waiting_time=$(bc <<< "scale=2; $total_waiting_time / $num_processes")
avg_turnaround_time=$(bc <<< "scale=2; $total_turnaround_time / $num_processes")

# Print the results
echo "Process   Arrival Time   Burst Time   Waiting Time   Turnaround Time"
for ((i=0; i<$num_processes; i++)); do
    echo "P$i         ${arrival_time[$i]}              ${burst_time[$i]}               ${waiting_time[$i]}                  ${turnaround_time[$i]}"
done

echo "Average Waiting Time: $avg_waiting_time"
echo "Average Turnaround Time: $avg_turnaround_time"

