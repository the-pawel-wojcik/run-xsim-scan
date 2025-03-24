#!/usr/bin/bash

# This scripts searches for a .template file and populates variable names for 
# use by other scripts. The list of variables available after sourcing this 
# script:
# - template: basename of the template file
# - nmodes: number of normal modes listed in the template file
# - extension: a description extension that can be added to the file name
# - keyword: the text in the template file that will be substituted
# - template_xxx: where xxx=lanczos, basis, energy, coupling, freq. 
#                 Set to "0" if corresponding keyword is in the template file.
#                 "1" otherwise.
# Additionally this script looks into the pwd and tells name of the molecule
# - molecule: ozone or pyrazine

template=$(ls *.template)
export template=${template%%.template}

nmodes=$(grep -A 1 "Modes" $template.template | tail -n 1)
export nmodes

grep 'TEMPLATE_LANCZOS' ${template}.template > /dev/null
export template_lanczos=$?
grep 'TEMPLATE_BASIS' ${template}.template > /dev/null
export template_basis=$?
grep 'TEMPLATE_ENERGY' ${template}.template > /dev/null
export template_energy=$?
grep 'TEMPLATE_COUPLING' ${template}.template > /dev/null
export template_coupling=$?
grep 'TEMPLATE_FREQUENCY' ${template}.template > /dev/null
export template_freq=$?

if [[ "$template_lanczos" != "0" && "$template_basis" != "0"  && "$template_energy" != "0" && "$template_coupling" != "0" && "$template_freq" != "0" ]]
then
    {
    echo $(basename $0): Error: The template file misses the template string.
    echo Lanczos: $template_lanczos
    echo Basis: $template_basis
    echo Energy: $template_energy
    echo Coupling: $template_coupling
    echo Frequency: $template_freq
} >&2
    exit 1
fi

if [[ "$template_basis" == 0 ]]
then
    extension=qt
    keyword=TEMPLATE_BASIS
fi

if [[ "$template_lanczos" == 0 ]]
then
    extension=l
    keyword=TEMPLATE_LANCZOS
fi

if [[ "$template_energy" == 0 ]]
then
    extension=e
    keyword=TEMPLATE_ENERGY
fi

if [[ "$template_coupling" == 0 ]]
then
    extension=c
    keyword=TEMPLATE_COUPLING
fi

if [[ "$template_freq" == 0 ]]
then
    extension=cm-1
    keyword=TEMPLATE_FREQUENCY
fi

export extension
export keyword

molecule=""
pwd | grep 'ozone' &> /dev/null
if [[ $? == 0 ]]
then
    molecule="ozone"
fi

pwd | grep 'pyrazine' &> /dev/null
if [[ $? == 0 ]]
then
    molecule="pyrazine"
fi

pwd | grep 'sroph' &> /dev/null
if [[ $? == 0 ]]
then
    molecule="sroph"
fi

pwd | grep 'SrOPh' &> /dev/null
if [[ $? == 0 ]]
then
    molecule="sroph"
fi

pwd | grep 'caoph' &> /dev/null
if [[ $? == 0 ]]
then
    molecule="caoph"
fi

if [[ -z "$molecule" ]]
then
    echo Error. Path does not tell what molecule this is. >&2
fi

export molecule
