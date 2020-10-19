# Cache MC sample of model for FIM calculation.
# Author: Eddie Lee, edlee@santafe.edu
from pyutils import *


soln = MESolution('171017_154139', 0, 'a', 'xi', 'A')
soln.setup_model(1_000_000)
