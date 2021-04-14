# ====================================================================================== #
# Cache MC sample of model for FIM calculation.
# 
# Author: Eddie Lee, edlee@santafe.edu
# ====================================================================================== #
from pyutils import *


soln = CanonicalCouplingSolution('NAME', DATA, 'SOLN', 'MCSAMP', 'SUBSET', coarse_grain_type=2)
soln.setup_model(n_samples=100_000)

#soln = CoupSolution('NAME', DATA, 'SOLN', 'MCSAMP', 'SUBSET', coarse_grain_type=2)
#soln.setup_model(n_samples=100_000)
