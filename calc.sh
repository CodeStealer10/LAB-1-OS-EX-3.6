#!/bin/bash
Pham Nhat buoi`
TARGET="./calc"
HIST="./hist.txt"

echo "running Calculator"

if [[ -f $HIST ]]; then
    rm $HIST
fi
touch $HIST

while true; do
    echo -n ">> "
    read num1 op num2

    if [[ $num1 == "exit" ]]; then
        
        exit 0
    elif [[ $num1 == "HIST" ]]; then
        
        tail -n 5 $HIST 
        continue
    elif [[ $num1 == "ANS" ]]; then
        num1=$(cat ans.txt)
    fi

    if [[ $num2 == "ANS" ]]; then
        num2=$(cat ans.txt)
    fi

    if [[ $op == "" || $num2 == "" ]]; then
        result="SYNTAX ERROR"
    else
        result=$(echo "scale=2; $num1 $op $num2" | bc 2> /dev/null)
    fi
    #echo "$result"

    if [[ "$result" =~ ^\.[0-9]+$ ]]; then
        result="0$result"
    fi

    if [[ -z $result || $result == "SYNTAX ERROR" || $result == "MATH ERROR" ]]; then
        if [[ $result == "SYNTAX ERROR" ]]; then
            echo "SYNTAX ERROR"
            echo "SYNTAX ERROR" >> $HIST
        else
            echo "MATH ERROR"
            echo "MATH ERROR" >> $HIST
        fi
        continue
    else
        echo "$num1 $op $num2 = $result" >> $HIST
        echo "$result"
        echo "$result" > "ans.txt"
    fi
done
