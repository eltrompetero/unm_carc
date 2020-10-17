#! /bin/bash
# Script for copying over files into UNM cluster to prep.
# Author: Eddie Lee, edlee@santafe.edu

# symlink pyutils library
if [ ! -d "pyutils" ]
then
    ln -s ../py/pyutils pyutils
fi

cp run.py.template run.py
cp run.sh.template run.sh
sed -i 's/MX_NODES/400/' run.py
sed -i 's/MX_NODES/400/' run.sh

# Sync server for computation.
# All the files will be mirrored into the corresponding py directory including the python script files from
# this cluster directory.
rsync -avz --delete --exclude '.git' --exclude '__pycache__' --info=progress2 --copy-links \
    *.sh \
    run.py \
    pickle_model.py \
    ~/Dropbox/Research/scotus4/py/pyutils \
    gibbs:~/Dropbox/Research/scotus4/py/

