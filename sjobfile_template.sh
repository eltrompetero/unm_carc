#!/bin/bash

# First we provide the settings for the queueing system:
#SBATCH -J NAME
#SBATCH -N 1
#SBATCH --ntasks-per-node=1
#SBATCH --ntasks-per-core=1
#SBATCH --mail-type=FAIL # first have to state the type of event to occur
#SBATCH --mail-user=edlee@csh.ac.at   # and then your email address

module load miniconda3/4.6.14-intel-19.0.5.281-he6cj4y
source activate scotus4
cd ~/Dropbox/Research/scotus4/py

# now run whathever executable and parameters you want.
# this sample call to the echo command will just produce
# some output that is then stored to log
echo JOB_NO
python run.py JOB_NO INPUTFILE CAN
