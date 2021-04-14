# ====================================================================================== #
# Run file for generating models and pickling them.
# `bash run_pickle.sh`
# You should edit pickle_model.py first to set the right parameters.
# 
# Author: Eddie Lee, edlee@santafe.edu
# ====================================================================================== #
#!/bin/bash

# make temp dr
# this will be cleared at end of pickle_model.sh
tmpfile=$(mktemp -p ./)

rm $tmpfile
cp pickle_model.py ${tmpfile}.pickle_model.py 
cp pickle_model.sh ${tmpfile}.pickle_model.sh 

sed -i 's/NAME/'"${1}"'/' ${tmpfile}.pickle_model.py
sed -i 's/SUBSET/'"${2}"'/' ${tmpfile}.pickle_model.py
sed -i 's/DATA/'"${3}"'/' ${tmpfile}.pickle_model.py
sed -i 's/SOLN/'"${4}"'/' ${tmpfile}.pickle_model.py
sed -i 's/MCSAMP/'"${5}"'/' ${tmpfile}.pickle_model.py

sed -i "s|TMPFILE|${tmpfile}|" "${tmpfile}.pickle_model.sh"

if [[ `hostname` = "powerhouse" ]]; then
  bash ${tmpfile}.pickle_model.sh
else
  qsub -V ${tmpfile}.pickle_model.sh
fi
