#!/usr/bin/bash

if [[ ! -d scan ]]
then
    mkdir scan
fi

for n in $(seq 16 1 25)
do
    ./spawn-inputs.sh $n
done
