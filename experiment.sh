#!/bin/bash

#SBATCH --job-name=FeatUP_training     # Job name
#SBATCH --output=/home/t/tanriverdi/Desktop/FeatUp/slurm_logs/%x_%j.out
#SBATCH --error=/home/t/tanriverdi/Desktop/FeatUp/slurm_logs/%x_%j.err

#SBATCH --nodes=1                      # Number of nodes

#SBATCH --partition=NvidiaAll                # Partition name (change as needed)


cd featup
python3 train_implicit_upsampler.py
