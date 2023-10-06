# #FCFS Process Scheduling

# #!/bin/bash

# # Define the number of processes
# num_processes=4

# # Initialize arrays for process arrival time, burst time, and waiting time
# arrival_time=(0 1 2 3)
# burst_time=(8 4 1 3)
# waiting_time=()

# # Calculate waiting time for each process
# waiting_time[0]=0  # The first process has a waiting time of 0

# for ((i=1; i<$num_processes; i++)); do
#     waiting_time[$i]=$((waiting_time[$(($i-1))] + burst_time[$(($i-1))]))
# done

# # Calculate turnaround time for each process
# turnaround_time=()
# for ((i=0; i<$num_processes; i++)); do
#     turnaround_time[$i]=$((waiting_time[$i] + burst_time[$i]))
# done

# # Calculate average waiting time and average turnaround time
# total_waiting_time=0
# total_turnaround_time=0

# for ((i=0; i<$num_processes; i++)); do
#     total_waiting_time=$((total_waiting_time + waiting_time[$i]))
#     total_turnaround_time=$((total_turnaround_time + turnaround_time[$i]))
# done

# avg_waiting_time=$(($total_waiting_time / $num_processes))
# avg_turnaround_time=$(($total_turnaround_time / $num_processes))

# # Print the results
# echo "Process   Arrival Time   Burst Time   Waiting Time   Turnaround Time"
# for ((i=0; i<$num_processes; i++)); do
#     echo "P$i         ${arrival_time[$i]}              ${burst_time[$i]}               ${waiting_time[$i]}                  ${turnaround_time[$i]}"
# done

# echo "Average Waiting Time: $avg_waiting_time"
# echo "Average Turnaround Time: $avg_turnaround_time"

# ==============================================

#!/bin/bash

# Define variables
# n=0
# arrival_time=()
# burst_time=()
# pid=()
# waiting_time=()
# tat=()

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

# # Calculate the waiting time and turnaround time for each process
# total_waiting_time=0
# total_tat=0
# for ((i=0; i<$n; i++)) do
#   # Calculate the waiting time
#   waiting_time[i]=$((total_waiting_time))

#   # Calculate the turnaround time
#   tat[i]=$((waiting_time[i] + ${burst_time[$i]}))

#   # Update the total waiting time
#   total_waiting_time=$((total_waiting_time + ${burst_time[$i]}))
# done

# # Calculate the average waiting time and average turn around time
# avgwt='echo $total_waiting_time / $n'
# avgtat='echo $total_tat / $n'

# # Display the results
# echo -n "Average waiting time ="
# printf %.3f\\n "$avgwt"
# echo -n "Average turn around time ="
# printf %.3f\\n "$avgtat"

# ============================================
#!/bin/bash

# Define variables
n=0
arrival_time=()
burst_time=()
pid=()
waiting_time=()
tat=()

# Get the number of processes
echo -n "Enter the number of processes: "
read n

# Check if the user entered a valid number of processes
if [[ "$n" -lt 1 ]]; then
  echo "Invalid number of processes."
  exit 1
fi

# Get the arrival time and burst time of each process
for ((i=0; i<$n; i++)) do
  echo -n "Enter Process Id: "
  read pid[$i]

  echo -n "Enter arrival time: "
  read arrival_time[$i]

  # Check if the user entered a valid arrival time
  if [[ "${arrival_time[$i]}" -lt 0 ]]; then
    echo "Invalid arrival time."
    exit 1
  fi

  echo -n "Enter burst time: "
  read burst_time[$i]

  # Check if the user entered a valid burst time
  if [[ "${burst_time[$i]}" -lt 0 ]]; then
    echo "Invalid burst time."
    exit 1
  fi
done

# Calculate the waiting time and turnaround time for each process
total_waiting_time=0
total_tat=0
for ((i=0; i<$n; i++)) do
  # Calculate the waiting time
  waiting_time[i]=$((total_waiting_time))

  # Calculate the turnaround time
  tat[i]=$((waiting_time[i] + ${burst_time[$i]}))

  # Update the total waiting time
  total_waiting_time=$((total_waiting_time + ${burst_time[$i]}))
done

# Calculate the average waiting time and average turn around time
avgwt=$(echo "scale=3; $total_waiting_time / $n" | bc)
avgtat=$(echo "scale=3; $total_tat / $n" | bc)

# Display the results
echo -n "Average waiting time ="
printf %.3f\\n "$avgwt"
echo -n "Average turn around time ="
printf %.3f\\n "$avgtat"