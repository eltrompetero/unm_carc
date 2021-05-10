# ====================================================================================== #
# Script for copying over files into SFI computing cluster.
# 
# Author: Eddie Lee, edlee@santafe.edu
# ====================================================================================== #
#! /bin/bash

# symlink pyutils library
if [ ! -d "pyutils" ]
then
    ln -s ../py/pyutils pyutils
fi

cp run.py.template run.py
cp run.sh.template run.sh
sed -i 's/MX_NODES/4/' run.py
sed -i 's/MX_NODES/4/' run.sh

# Sync server for computation.
# All the files will be mirrored into the corresponding py directory including the python
# script files from this cluster directory.

echo "Syncing head node jalapeno..."
rsync -avz --delete \
    --exclude '.git' --exclude '__pycache__' --exclude 'tmp.*' \
    --info=progress2 --copy-links \
    *.sh \
    run.py \
    pickle_model.py \
    ~/Dropbox/Research/scotus4/py/pyutils \
    jalapeno:~/Dropbox/Research/scotus4/py/

# sync remaining nodes since they do not share disk space
for HOST in habanero serrano pequin
do
  ssh jalapeno "echo \"Syncing $HOST...\";
                rsync -azu --delete --progress --exclude '.ssh' /home/edlee/ $HOST:/home/edlee"
done

