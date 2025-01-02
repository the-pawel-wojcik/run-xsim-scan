#!/usr/bin/bash

if [[ "$#" -gt 2 ]]
then
    echo Usage: $(basename $0) [cluster] >&2
    exit 1
fi

case "$1" in 
    (school) cluster=school;;
    (hpc) cluster=hpctransfer;;
    (*) echo Info: Using default cluster.
        cluster=school;;
esac

# source variables named "template" and "molecule"
source get-tmplt-name.sh

if [[ -z "$molecule" ]]
then
    echo Error: Unknown molecule. >&2
    exit 1
fi

if [[ ! -d scan ]]
then
    echo Error: missing the directory named scan. >&2
    exit 1
fi

cd scan

if [[ "$molecule" == "caoph" ]]
then
    rsync -avP *.input ${cluster}:~/cci/phenoxide/calcium/xsim
else
    rsync -avP *.input ${cluster}:~/${molecule}/xsim
fi
