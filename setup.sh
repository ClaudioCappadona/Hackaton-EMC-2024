#!/bin/bash
#SBATCH -t 1:00:00
#SBATCH -N 1
#SBATCH -p express
#SBATCH --gres=gpu:1 # if you want to use GPU
#SBATCH -o jupyter-notebook-job.out

module load Python/3.10.8-GCCcore-12.2.0 # 3.9.5-GCCcore-10.3.0

# At first setup, created a virtual enviroment, called .venv
# python3 venv -m .venv

# Activate virtual enviroment
source .venv/bin/activate
# pip install --upgrade pip
# pip install requirements.txt # make sure you have the packages we need


# Load the other necessary modules
module purge
module load CUDA/11.3.1


# Choose random port and print instructions to connect
PORT=`shuf -i 5000-5999 -n 1`
LOGIN_HOST=${SLURM_SUBMIT_HOST}.research.erasmusmc.nl 
BATCH_HOST=$(hostname)
 
echo "To connect to the notebook type the following command into your local terminal:"
echo "ssh -N -J ${USER}@${LOGIN_HOST} ${USER}@${BATCH_HOST} -L ${PORT}:localhost:${PORT}"

# start the Jupyter Notebooks server
jupyter notebook --no-browser --port $PORT

