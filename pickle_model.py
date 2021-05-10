# ====================================================================================== #
# Cache MC sample of model for FIM calculation.
# 
# Author: Eddie Lee, edlee@santafe.edu
# ====================================================================================== #
from pyutils import *

# capitalized names will be replaced with regex by run_pickle.sh
soln = TYPESolution('NAME', DATA, 'SOLN', 'MCSAMP', 'SUBSET',
                    coarse_grain_type=CG_TYPE)
soln.setup_model(n_samples=100_000)
