# Get pickles from Gibbs UNM server 
# 
# Author: Eddie Lee, edlee@csh.ac.at

#!/bin/bash

rsync -azu --progress gibbs:~/Dropbox/Research/scotus4/py/$1 cache/
