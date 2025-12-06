#! /bin/bash
declare -a problems
declare -i row_idx=0
declare -i cols=0
declare -i ans=0

set -f

while read line; do
    declare -i col_idx=0
    arr=( $line )
    cols=${#arr[@]}
    for ch in ${arr[@]}; do
        # echo $ch
        declare -i idx=$(( row_idx * cols + col_idx))
        problems[idx]=$ch
        col_idx+=1
    done
    row_idx+=1
done < "input.txt"

for((c=0; c<cols; c+=1)); do
    last_row_idx=$((row_idx - 1))
    declare -i op_idx=$((last_row_idx * cols + c))
    operator=${problems[op_idx]}
    # echo "DEBUG: Row $r, Operator is '$operator'"
    if [ "$operator" == "+" ]; then
        declare -i temp=0
        for((r=0; r<last_row_idx; r+=1)); do
            val_idx=$(( r * cols + c ))
            val=${problems[$val_idx]}
            (( temp += val ))
        done
        (( ans += temp ))
    else
        declare -i temp=1
        for((r=0; r<last_row_idx; r+=1)); do
            val_idx=$(( r * cols + c ))
            val=${problems[$val_idx]}
            (( temp *= val ))
        done
        (( ans += temp ))
    fi
done

echo $ans
