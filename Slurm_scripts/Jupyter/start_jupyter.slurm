#!/bin/bash
# Configuration values for a SLURM batch job.
# One leading hash(#) before the word SBATCH is not a comment, but two are.
#SBATCH --job-name=jupyteronslurm
#SBATCH --nodes=1                 # Ensure that all cores are on one machine
#SBATCH --ntasks=1                # Run a single task
#SBATCH --cpus-per-task=16         # Enter number of cores/threads you wish to request
#SBATCH --mem=256gb                # Enter amount of memory you wish to request
#SBATCH --time 1-00:00:00           # max time that the job/jupyter instance actually needs to be running (in dd:hh:mm format)
#SBATCH --account=weissman        # weissman account needed for sabre access
#SBATCH --partition=weissman         # partition (queue) to use
#SBATCH -o /lab/weissman_imaging/puzheng/slurm_reports/Jupyter/%x_%j.stdout
#SBATCH -e /lab/weissman_imaging/puzheng/slurm_reports/Jupyter/%x_%j.stdout

#SBATCH --mail-type=ALL
#SBATCH --mail-user=puzheng@wi.mit.edu

source /home/puzheng/miniconda3/etc/profile.d/conda.sh

venvname="postanalysis"      # change text between quotes to the actual name of environment

conda activate $venvname

# Workaround for jupyter bug
unset XDG_RUNTIME_DIR

#jupyter notebook 
jupyter-lab \
--no-browser \
--port-retries=0 \
--ip=0.0.0.0 \
--port=`shuf -i 8990-10000 -n 1` \
--notebook-dir=/lab/weissman_imaging/puzheng/Softwares/Weissman_MERFISH_Scripts/ \
--LabApp.default_url="/lab/tree/home/$(whoami)"
