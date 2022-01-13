# Get pickles from clusters
# 
# Author: Eddie Lee, edlee@csh.ac.at

#!/bin/bash

rsync -azu --progress $2:~/Dropbox/Research/scotus4/py/$1 cache/
