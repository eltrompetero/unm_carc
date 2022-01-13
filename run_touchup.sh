#!/bin/bash
# Automate submission of jobs to gibbs nodes. This should be run on the head
# node, gibbs.alliance.unm.edu and will call qsub.
# Pass in model file pickle name.
# 
# Author: Eddie Lee, edlee@santafe.edu
# 2020-10-17

start_job () {
    # fill in temp jobfile directions
    cp jobfile_template.sh jobfile.sh\~
    sed -i 's/JOB_NO/'"${1}"'/' jobfile.sh\~
    sed -i 's/INPUTFILE/'"${2}.p"'/' jobfile.sh\~

    # make directory where results will be saved
    if [ ! -d $2 ]; then
      mkdir $2
    fi

    # call qsub
    qsub -V jobfile.sh\~
    rm jobfile.sh\~
}

if [ ! -f "${2}.p" ]; then
    echo "Error: File $2.p does not exist."
    exit 1
fi

echo "start_job $1 $2"
start_job $1 $2
