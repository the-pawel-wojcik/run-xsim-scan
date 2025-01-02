#!/usr/bin/env bash

# source variable named "template" and "extension"
source get-tmplt-name.sh

if [[ $# != 1 ]]
then
    {
        echo use: $(basename $0) val
        echo "     val is the new template value. It will be used to replace"
        echo "     the $keyword line."
    } >&2
    exit 1
fi

if [[ "$template_freq" -eq "0" || "$template_lanczos" -eq "0" ]] 
then
    export new_val=$1
    export number=$(printf "%04d" $1)
elif [[ "$template_basis" -eq "0" ]]
then
    basis=""
    for i in $(seq $nmodes)
    do
        basis="$basis$1 "
    done
    basis=${basis::-1}

    export new_val=$basis
    export number=$(printf "%02d" $1)
fi

if [[ ! -d scan ]]
then
    mkdir scan
fi

sed "s#$keyword#$new_val#" < ${template}.template > scan/${template}_${number}${extension}.input
