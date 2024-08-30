# Set default values
$default_model = "vit"
$default_upsampler = "jbu_stack"
$default_loss = "multiview_loss"


# Function to write the YAML configuration file
function Write-ConfigFile($model, $upsampler, $loss) {
    $yamlContent = @"
# Environment Args
output_root: '../'
pytorch_data_dir: 'pytorch-data'
submitting_to_aml: false

# Dataset args
dataset: "cocostuff"

# Model Args
model_type: "$model"
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
"@
    Set-Content -Path "C:\Users\Ozan Tanriverdi\Desktop\FeatUp-Ubuntu-cip\FeatUp\featup\configs\jbu_upsampler.yaml" -Value $yamlContent
}

# Start in Featup
cd featup

# maskclip - jbu - multiview
$model = "maskclip"
Write-ConfigFile $model $default_upsampler $default_loss
python train_jbu_upsampler.py

# maskclip - transformer - multiview
$upsampler = "transformer"
Write-ConfigFile $model $upsampler $default_loss
python train_jbu_upsampler.py

# $upsampler = "unet_guided"
# Write-ConfigFile $default_model $upsampler $default_loss
# python train_jbu_upsampler.py

Write-ConfigFile $default_model $default_upsampler $default_loss