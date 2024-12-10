#!/usr/bin/bash

if [[ "$#" -gt 2 ]]
then
    echo Usage: $(basename $0) [cluster] >&2
    exit 1
fi

# source variables named "template" and "molecule"
source get-tmplt-name.sh

if [[ -z "$molecule" ]]
then
    echo Error: Unknown molecule. >&2
    exit 1
fi

case "$1" in 
    (school) cluster=school;;
    (hpc) cluster=hpctransfer;;
    (*) echo Info: Using default cluster.
        cluster=school;;
esac

if [[ ! -d scan ]]
then
    mkdir scan
fi

if [[ "$molecule" -eq "caoph" ]]
then
    rsync -avP ${cluster}:~/cci/phenoxide/calcium/xsim/${template}_* ./scan
else
    rsync -avP ${cluster}:~/${molecule}/xsim/${template}_* ./scan
fi
