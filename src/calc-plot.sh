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
    # replace each underscore with a space; form an array from separated words
    array=(${base//_/ })
    case_name=${array[2]}
    echo Plotting $case_name
    b_position=${case_name::-1}
    a_position=14487
    AB_gap=$(($b_position - $a_position))
    xsimplot.py\
        -f "$case_name".svg\
        --spectrum_format 'fort.20'\
        --spectrum_files A-${base}/fort.20 B-${base}/fort.20 C-${base}/fort.20\
        --annotate "a\$\tilde{A}\$-\$\tilde{B}\$ gap = ${AB_gap}" #\
        # --scale_factor 0.7\
        # --position_annotation 'top center'\
        # --second_ax 'cm offset'
done
