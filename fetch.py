# ====================================================================================== #
# Automate fetching single folder of computations.
# 
# This will import folder of results from Gibbs and combine them into a single FIM and
# save it into the appropriate folder. You must start the computation on the server.
# 
# Run from command line as
# python fetch.py [BASE] [SPEC] [PARAM] [COARSE_GRAIN] [CAN OR NOT] [SERVER]
#
# Author : Eddie Lee, edlee@csh.ac.at
# ====================================================================================== #
import numpy as np
from time import sleep
from subprocess import run
import os, sys
import dill as pickle

from pyutils.utils import combine_fim_files
from workspace.utils import save_pickle



def fetch_files(base, suffix, param_type, coarse_grain_type, can, server):
    success = False
    while not success:
        try:
            print(f"Trying import {base}_model{suffix}...")
            run(['bash', 'fetch.sh', f'{base}_model{suffix}', server])
            fim, success = combine_fim_files(*[f'cache/{base}_model{suffix}/{f}'
                                               for f in os.listdir(f'cache/{base}_model{suffix}')])
        except (FileNotFoundError, IndexError):
            pass
        finally:
            if not success:
                print("Waiting for 4 hours...")
                sleep(7200)
                print("Waiting for 2 hours...")
                sleep(3600)
                print("Waiting for 1 hour...")
                sleep(1800)
                print("Waiting for 30 minutes...")
                sleep(1800)
    print(f"Successfully imported folder cache/{base}_model{suffix}")
    return fim

def write_file(fim, base, suffix, param_type, coarse_grain_type, can):
    """Write to fim file.
    """

    success = True
    overwrite = True
    name = base
    dry_run = False

    if can:
        fname = f'cache/c_elegans/can_{param_type}3/{coarse_grain_type}/{base}_fim{suffix}.p'
    else:
        fname = f'cache/c_elegans/{param_type}3/{coarse_grain_type}/{base}_fim{suffix}.p'

    if dry_run:
        print('Dry run...')
        print(f'Saving {fname}')
    else:
        print(f'Saving {fname}...')
        if os.path.isfile(fname):
            ofim = pickle.load(open(fname,'rb'))['fim']
            if np.array_equal(ofim, fim):
                print(f'File with same FIM already exists.')
            else:
                save_pickle(['fim','success','name'],
                            fname, overwrite)
                print('Saved.')
        else:
            save_pickle(['fim','success','name'],
                        fname, overwrite)

            print('Saved.')

if __name__=='__main__':
    assert len(sys.argv)==6 or len(sys.argv)==7, f'len(sys.argv) args given'

    base = sys.argv[1]
    suffix = sys.argv[2]
    param_type = sys.argv[3]
    coarse_grain_type = int(sys.argv[4])
    can = False if sys.argv[5]=='0' else True
    try:
        server = sys.argv[6]
    except:
        server = 'gibbs'

    assert coarse_grain_type in [1,2]
    
    fim = fetch_files(base, suffix, param_type, coarse_grain_type, can, server)
    write_file(fim, base, suffix, param_type, coarse_grain_type, can)
