# ====================================================================================== #
# Modified from Nate's howto with Scoville.
# Author: Eddie Lee, edlee@santafe.edu
# ====================================================================================== #
#!/bin/bash

# First we provide the settings for the queueing system:
#PBS -l nodes=1
#PBS -l walltime=5:00:00
#PBS -N EDDIE_FIM_JOB_NO
#PBS -o ${PBS_JOBNAME}JOB_NO.log
#PBS -j oe
#PBS -M edlee@santafe.edu

# -l can be used to choose the maximum run time in h:m:s
# -N can be used to set a job name (so you can recognize it)
# -o sets where the output should go (relative to work dir)
# -j oe  send both stdout and stderr to the same file

# Note: within these PBS queueing settings, you can only use
#       PBS variables such as ${PBS_JOBNAME} and ${PBS_JOBID}
#       but NOT your own variables, even if defined before!

# After all the settings, you can choose where and how to
# run your executable file

# in case you want to run your executable in a specific place:
# make sure the work dir exists (you don't know which node the
# job will run on) then change directory into the work dir
if [[ `hostname` == *"gibbs"* ]]; then
  echo "Loading miniconda on Gibbs."
  module load miniconda3-4.8.2-gcc-10.2.0-zu7qwdd
  source activate scotus4
  cd ~/Dropbox/Research/scotus4/py
elif [[ `hostname` = *"wheeler"* ]]; then
  module load miniconda3-4.7.12.1-gcc-4.8.5-lmtvtik
  echo "Loading miniconda on Wheeler."
  source activate scotus4
  cd ~/Dropbox/Research/scotus4/py
elif [[ `hostname` = "powerhouse" ]]; then
  :
fi

# now run whathever executable and parameters you want.
# this sample call to the echo command will just produce
# some output that is then stored to log
echo JOB_NO
python run.py JOB_NO INPUTFILE
