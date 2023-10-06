#C-Scan

#!/bin/bash

# Define variables
n=0
arrival_time=()
burst_time=()
pid=()
waiting_time=()
tat=()
head=0
total_seek_time=0

# Get the number of processes
echo -n "Enter the number of processes: "
read n

# Get the arrival time and burst time of each process
for ((i=0; i<$n; i++)) do
  echo -n "Enter Process Id: "
  read pid[$i]
  echo -n "Enter arrival time: "
  read arrival_time[$i]
  echo -n "Enter burst time: "
  read burst_time[$i]
done

# Sort the processes according to their arrival time
sort

# Initialize the head position
head=${arrival_time[0]}

# Schedule the processes
for ((i=0; i<$n; i++)) do
  # Calculate the seek time
  seek_time=$((head - ${arrival_time[$i]}))

  # Update the head position
  head=${arrival_time[$i]}

  # Add the seek time to the total seek time
  total_seek_time=$((total_seek_time + seek_time))

  # Calculate the waiting time
  waiting_time[i]=$((total_seek_time - ${burst_time[$i]}))

  # Calculate the turn around time
  tat[i]=$((waiting_time[i] + ${burst_time[$i]}))
done

# Calculate the average waiting time and average turn around time
avgwt=`echo "scale=3; $total_waiting_time / $n" | bc`
avgtat=`echo "scale=3; $total_tat / $n" | bc`

# Display the results
echo -n "Average waiting time ="
printf %.3f\\n "$avgwt"
echo -n "Average turn around time ="
printf %.3f\\n "$avgtat"

# Print the Gantt chart
echo -n "0 "
for ((i=0; i<$n; i++)) do
  echo -n "`expr ${arrival_time[$i]} + ${tat[$i]}`"
  echo -n " "
done
echo ""