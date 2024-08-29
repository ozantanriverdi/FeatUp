#!/bin/bash

#SBATCH --job-name=FeatUP_training     # Job name
#SBATCH --output=/home/t/tanriverdi/Desktop/FeatUp/slurm_logs/%x_%j.out
#SBATCH --error=/home/t/tanriverdi/Desktop/FeatUp/slurm_logs/%x_%j.err

#SBATCH --nodes=1                      # Number of nodes

#SBATCH --partition=NvidiaAll   # Partition name (change as needed)

default_model="vit"
default_upsampler="jbu_stack"
default_loss="multiview_loss"

# 1. Default Experiment
cd featup
python3 train_jbu_upsampler.py
cd ..
git add .
git commit -m "training results from cip pool"
git push origin main




# 2. loss = simple
loss="simple_loss"
cat <<EOF >featup/configs/jbu_upsampler.yaml
# Environment Args
output_root: '../'
pytorch_data_dir: 'pytorch-data'
submitting_to_aml: false

# Dataset args
dataset: "cocostuff"

# Model Args
model_type: "vit"
activation_type: "token"

# Upsampling args
outlier_detection: True
upsampler_type: "jbu_stack" # jbu_stack | transformer | unet_guided | bilinear
downsampler_type: "attention"
max_pad: 20
max_zoom: 2
n_jitters: 5
random_projection: 30
crf_weight: 0.001
filter_ent_weight: 0.0
tv_weight: 0.0
loss: "$loss" # multiview_loss | simple_loss

implicit_sup_weight: 1.0

# Training args
batch_size: 2
epochs: 1
num_gpus: 1
num_workers: 12
lr: 1e-3

# No need to change
hydra:
  run:
    dir: "."
  output_subdir: ~


EOF
cd featup
python3 train_jbu_upsampler.py
cd ..
git add .
git commit -m "training results from cip pool"
git push origin main




# 3. upsampler_type = transformer
upsampler="transformer"
cat <<EOF >featup/configs/jbu_upsampler.yaml
# Environment Args
output_root: '../'
pytorch_data_dir: 'pytorch-data'
submitting_to_aml: false

# Dataset args
dataset: "cocostuff"

# Model Args
model_type: "vit"
activation_type: "token"

# Upsampling args
outlier_detection: True
upsampler_type: "$upsampler" # jbu_stack | transformer | unet_guided | bilinear
downsampler_type: "attention"
max_pad: 20
max_zoom: 2
n_jitters: 5
random_projection: 30
crf_weight: 0.001
filter_ent_weight: 0.0
tv_weight: 0.0
loss: "$default_loss" # multiview_loss | simple_loss

implicit_sup_weight: 1.0

# Training args
batch_size: 2
epochs: 1
num_gpus: 1
num_workers: 12
lr: 1e-3

# No need to change
hydra:
  run:
    dir: "."
  output_subdir: ~


EOF
cd featup
python3 train_jbu_upsampler.py
cd ..
git add .
git commit -m "training results from cip pool"
git push origin main




# 4. upsampler_type = unet_guided
upsampler="unet_guided"
cat <<EOF >featup/configs/jbu_upsampler.yaml
# Environment Args
output_root: '../'
pytorch_data_dir: 'pytorch-data'
submitting_to_aml: false

# Dataset args
dataset: "cocostuff"

# Model Args
model_type: "vit"
activation_type: "token"

# Upsampling args
outlier_detection: True
upsampler_type: "$upsampler" # jbu_stack | transformer | unet_guided | bilinear
downsampler_type: "attention"
max_pad: 20
max_zoom: 2
n_jitters: 5
random_projection: 30
crf_weight: 0.001
filter_ent_weight: 0.0
tv_weight: 0.0
loss: "$default_loss" # multiview_loss | simple_loss

implicit_sup_weight: 1.0

# Training args
batch_size: 2
epochs: 1
num_gpus: 1
num_workers: 12
lr: 1e-3

# No need to change
hydra:
  run:
    dir: "."
  output_subdir: ~


EOF
cd featup
python3 train_jbu_upsampler.py
cd ..
git add .
git commit -m "training results from cip pool"
git push origin main




# Bring back to default
cat <<EOF >featup/configs/jbu_upsampler.yaml
# Environment Args
output_root: '../'
pytorch_data_dir: 'pytorch-data'
submitting_to_aml: false

# Dataset args
dataset: "cocostuff"

# Model Args
model_type: "vit"
activation_type: "token"

# Upsampling args
outlier_detection: True
upsampler_type: "$default_upsampler" # jbu_stack | transformer | unet_guided | bilinear
downsampler_type: "attention"
max_pad: 20
max_zoom: 2
n_jitters: 5
random_projection: 30
crf_weight: 0.001
filter_ent_weight: 0.0
tv_weight: 0.0
loss: "$default_loss" # multiview_loss | simple_loss

implicit_sup_weight: 1.0

# Training args
batch_size: 2
epochs: 1
num_gpus: 1
num_workers: 12
lr: 1e-3

# No need to change
hydra:
  run:
    dir: "."
  output_subdir: ~


EOF
