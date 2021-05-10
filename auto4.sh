# ====================================================================================== #
# Automate set of four processes for FIM calculation.
# 
# Author : Eddie Lee, edlee@santafe.edu
# ====================================================================================== #
#!/bin/bash

if [[ $# -ne 3 ]]; then
  echo "Illegal number of args" >&2

DR=$1
BASE=$2
CAN=$3

echo 'Copying models into this directory...'
echo "Copying ${BASE}i.p"
cp $DR/${BASE}i.p ${BASE}i.p
echo "Copying ${BASE}ii.p"
cp $DR/${BASE}ii.p ${BASE}ii.p
echo "Copying ${BASE}iii.p"
cp $DR/${BASE}iii.p ${BASE}iii.p
echo "Copying ${BASE}iv.p"
cp $DR/${BASE}iv.p ${BASE}iv.p

./run.sh ${BASE}i $CAN
./run.sh ${BASE}ii $CAN
./run.sh ${BASE}iii $CAN
./run.sh ${BASE}iv $CAN
