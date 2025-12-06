#! /bin/bash

declare -a lines
declare -i width=0

while IFS='' read -r line || [ -n "$line" ]; do
    clean_line=${line//$'\r'/}
    lines+=("$clean_line")
    
    len=${#clean_line}
    if (( len > width )); then width=$len; fi
done < "input.txt"

declare -i height=${#lines[@]}
declare -i ans=0
declare -i num=0
operator="+"

declare -i op_idx=$((height - 1))
opline="${lines[$op_idx]}"

for ((x=0; x < width; x+=1)); do
    op_pos="${opline:x:1}"
    if [ "$op_pos" != " " ]; then
        operator="$op_pos"
        (( ans += num ))
        if [ "$operator" == "+" ]; then
            num=0
        else
            num=1
        fi
    fi

    declare -i temp=0
    declare -i found=0

    for ((r=0; r < op_idx; r+=1)); do
        line="${lines[$r]}"
        digit="${line:x:1}"
        if [[ "$digit" =~ [0-9] ]]; then
            found=1
            (( temp *= 10))
            (( temp += digit ))
        fi
    done
    if (( found == 1 )); then
        if [ "$operator" == "+" ]; then
            (( num += temp ))
        else
            (( num *= temp ))
        fi
    fi
done
(( ans += num ))
echo $ans
