#!/usr/bin/bash

# source variable named "template" and "molecule"
source get-tmplt-name.sh

cd scan
for base in ${template}_*
do 
    # base might be already the svg output picture
    if [[ ! -d "$base" ]]
    then
        continue
    fi
    array=(${base//_/ })
    case_name=${array[1]}
    echo Plotting $case_name
    xsimplot.py -f "$case_name".svg --spectrum_format 'xsim' ${base}/${base}.output --annotate "a${case_name}" --scale_factor 0.7 --position_annotation 'top center' --second_ax 'cm offset'
done
