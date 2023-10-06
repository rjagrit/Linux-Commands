# #Shortest Seek time CPU Algo
#!/bin/bash

# Define variables
n=0
requests=()
head=0
total_seek_time=0

# Get the number of requests
echo -n "Enter the number of requests: "
read n

# Get the requests
for ((i=0; i<$n; i++)) do
  echo -n "Enter request $i: "
  read requests[$i]
done

# Sort the requests in ascending order
for ((i=0; i<$n-1; i++)) do
  for ((j=i+1; j<$n; j++)) do
    if [ ${requests[$i]} -gt ${requests[$j]} ]; then
      temp=${requests[$i]}
      requests[$i]=${requests[$j]}
      requests[$j]=$temp
    fi
  done
done

# Schedule the requests
for ((i=0; i<$n; i++)) do
  # Calculate the seek time
  seek_time=$((requests[$i] - head))

  # Update the head position
  head=${requests[$i]}

  # Add the seek time to the total seek time
  total_seek_time=$((total_seek_time + (seek_time < 0 ? -seek_time : seek_time)))
done

# Display the total seek time
echo "Total seek time: $total_seek_time"

#=====================================================

# #!/bin/bash

# # Define the initial position of the disk head
# initial_head_position=50

# # Define an array of disk request queue
# request_queue=(30 10 80 90 20)

# # Function to find the request with the shortest seek time
# find_shortest_seek_time() {
#     shortest_seek_time=1000  # Set an initial large value
#     for req in "${request_queue[@]}"; do
#         seek_distance=$((req - initial_head_position))
#         if [ $seek_distance -lt 0 ]; then
#             seek_distance=$((seek_distance * -1))
#         fi
#         if [ $seek_distance -lt $shortest_seek_time ]; then
#             shortest_seek_time=$seek_distance
#             next_request=$req
#         fi
#     done
# }

# # Initialize variables for total seek time and seek sequence
# total_seek_time=0
# seek_sequence=()

# # Process requests in SSTF order
# while [ ${#request_queue[@]} -gt 0 ]; do
#     find_shortest_seek_time
#     seek_sequence+=($next_request)
#     total_seek_time=$((total_seek_time + shortest_seek_time))
#     initial_head_position=$next_request
#     request_queue=("${request_queue[@]/$next_request}")
# done

# # Print the seek sequence and total seek time
# echo "Seek Sequence: ${seek_sequence[@]}"
# echo "Total Seek Time: $total_seek_time"
# =============================================
#!/bin/bash

# # Define the queue of disk requests
# request_queue=(40 10 35 7 15 45 25)

# # Initialize the current head position
# current_head=20

# # Function to find the request with the shortest seek time
# find_shortest_seek_time() {
#     shortest_seek_time=1000  # Initialize to a large value
#     next_request=0

#     for req in "${request_queue[@]}"; do
#         seek_distance=$((req - current_head))
#         if [ $seek_distance -lt 0 ]; then
#             seek_distance=$((seek_distance * -1))
#         fi

#         if [ $seek_distance -lt $shortest_seek_time ]; then
#             shortest_seek_time=$seek_distance
#             next_request=$req
#         fi
#     done
# }

# # Initialize variables for total seek time and seek sequence
# total_seek_time=0
# seek_sequence=()

# # Process requests in SSTF order
# while [ ${#request_queue[@]} -gt 0 ]; do
#     find_shortest_seek_time
#     seek_sequence+=($next_request)
#     total_seek_time=$((total_seek_time + shortest_seek_time))
#     current_head=$next_request
#     request_queue=("${request_queue[@]/$next_request}")
# done

# # Print the seek sequence and total seek time
# echo "Seek Sequence: ${seek_sequence[@]}"
# echo "Total Seek Time: $total_seek_time"
