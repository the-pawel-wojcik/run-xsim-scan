#!/bin/bash

cd scan
for fname in *input
do
    sed 's/2.273 2.670 2.715/0.000 2.670 0.000/' $(fname) > A-$(fname)
    sed 's/2.273 2.670 2.715/0.000 0.000 2.715/' $(fname) > B-$(fname)
    sed 's/2.273 2.670 2.715/2.273 0.000 0.000/' $(fname) > C-$(fname)
done
