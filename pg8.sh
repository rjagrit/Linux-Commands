# #Scan

# #!/bin/bash

# # Define variables
# n=0
# requests=()
# head=0
# total_seek_time=0
# max_track=199 # Maximum track number

# # Get the number of requests
# echo -n "Enter the number of requests: "
# read n

# # Get the requests
# for ((i=0; i<$n; i++)) do
#   echo -n "Enter request $i: "
#   read requests[$i]
# done

# # Sort the requests in ascending order
# IFS=$'\n' sorted=($(sort <<<"${requests[*]}"))
# unset IFS
# requests=("${sorted[@]}")

# # Get the initial direction (0 for right, 1 for left)
# echo -n "Enter initial direction (0 for right, 1 for left): "
# read direction

# # Serve the requests
# while [ ${#requests[@]} -gt 0 ]; do
#   if [ "$direction" -eq 0 ]; then
#     for ((i=0; i<${#requests[@]}; i++)); do
#       if [ ${requests[$i]} -ge $head ]; then
#         seek_time=$((requests[$i] - head))
#         head=${requests[$i]}
#         total_seek_time=$((total_seek_time + seek_time))
#         unset "requests[$i]"
#         requests=("${requests[@]}")
#         break
#       fi
#     done
#     direction=1 # Reverse direction
#   else
#     for ((i=${#requests[@]}-1; i>=0; i--)); do
#       if [ ${requests[$i]} -le $head ]; then
#         seek_time=$((head - requests[$i]))
#         head=${requests[$i]}
#         total_seek_time=$((total_seek_time + seek_time))
#         unset "requests[$i]"
#         requests=("${requests[@]}")
#         break
#       fi
#     done
#     direction=0 # Reverse direction
#   fi
# done

# # Display the total seek time
# echo "Total seek time: $total_seek_time"

# ================================================
#!/bin/bash

# Define the queue of disk requests
request_queue=(98 183 37 122 14 124 65 67)

# Initialize the current head position
current_head=53

# Define the direction of head movement (1 for right, -1 for left)
direction=1

# Sort the request queue based on their positions
IFS=$'\n' request_queue=($(sort -n <<<"${request_queue[*]}"))
unset IFS

# Find the index where the current head is located
current_index=0
for ((i = 0; i < ${#request_queue[@]}; i++)); do
    if [ ${request_queue[$i]} -eq $current_head ]; then
        current_index=$i
        break
    fi
done

# Initialize variables for total seek time and seek sequence
total_seek_time=0
seek_sequence=()

# SCAN algorithm
while [ ${#request_queue[@]} -gt 0 ]; do
    if [ $direction -eq 1 ]; then
        for ((i = current_index; i < ${#request_queue[@]}; i++)); do
            seek_sequence+=(${request_queue[$i]})
            seek_distance=$((request_queue[$i] - current_head))
            total_seek_time=$((total_seek_time + seek_distance))
            current_head=${request_queue[$i]}
        done
        direction=-1
    else
        for ((i = current_index; i >= 0; i--)); do
            seek_sequence+=(${request_queue[$i]})
            seek_distance=$((current_head - request_queue[$i]))
            total_seek_time=$((total_seek_time + seek_distance))
            current_head=${request_queue[$i]}
        done
        direction=1
    fi

    # Remove the processed request from the queue
    unset 'request_queue[$current_index]'
    
    # Find the next request in the current direction
    next_index=$current_index
    while [ $next_index -ge 0 ] && [ $next_index -lt ${#request_queue[@]} ] && [ -z "${request_queue[$next_index]}" ]; do
        next_index=$((next_index + direction))
    done
    current_index=$next_index
done

# Print the seek sequence and total seek time
echo "Seek Sequence: ${seek_sequence[@]}"
echo "Total Seek Time: $total_seek_time"
