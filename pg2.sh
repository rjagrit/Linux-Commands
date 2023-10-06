echo -n "Enter a value of n : "
read num
let i=1
echo 
while [ $i -le $num ]
do 
echo -n "$i, "
let i=i+1
done 

# -n is used for not giving the new linex6