# ====================================================================================== #
# Run file for generating models and pickling them.
# `bash run_pickle.sh 171017_170419_indpt A 0 a i 1 Coup`
# 
# Author: Eddie Lee, edlee@csh.ac.at
# ====================================================================================== #
#!/bin/bash

# make temp dr
# this will be cleared at end of pickle_model.sh
tmpfile=$(mktemp -p ./)

rm $tmpfile
cp pickle_model.py ${tmpfile}.pickle_model.py 
cp spickle_model.sh ${tmpfile}.pickle_model.sh 

sed -i 's/NAME/'"${1}"'/' ${tmpfile}.pickle_model.py
sed -i 's/SUBSET/'"${2}"'/' ${tmpfile}.pickle_model.py
sed -i 's/DATA/'"${3}"'/' ${tmpfile}.pickle_model.py
sed -i 's/SOLN/'"${4}"'/' ${tmpfile}.pickle_model.py
sed -i 's/MCSAMP/'"${5}"'/' ${tmpfile}.pickle_model.py
sed -i 's/CG_TYPE/'"${6}"'/' ${tmpfile}.pickle_model.py
sed -i 's/TYPE/'"${7}"'/' ${tmpfile}.pickle_model.py

sed -i "s|TMPFILE|${tmpfile}|" "${tmpfile}.pickle_model.sh"

sbatch ${tmpfile}.pickle_model.sh
