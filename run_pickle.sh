#!/bin/bash
# Run file for generating models and pickling them.
# `bash run_pickle.sh`
# You should edit pickle_model.py first to set the right parameters.
# Author: Eddie Lee, edlee@santafe.edu

# make temp dr
# this will be cleared at end of pickle_model.sh
tmpfile=$(mktemp -p ./)

rm $tmpfile
cp pickle_model.py ${tmpfile}.pickle_model.py 
cp pickle_model.sh ${tmpfile}.pickle_model.sh 
sed -i "s|TMPFILE|${tmpfile}|" "${tmpfile}.pickle_model.sh"

qsub -V ${tmpfile}.pickle_model.sh
