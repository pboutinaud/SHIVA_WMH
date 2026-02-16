#!/bin/bash
# Example script to run segmentation prediction for WMH (White Matter Hyperintensities)
# Supports both old .h5 (v0/v1) and new SavedModel (v2) model formats.
#
# Adjust MODEL_DIR, IMAGE_DIR and output path to your setup.
# --batch_size: number of slices per batch (increase for GPU, default 1 for CPU)
# --gpu: GPU index to use (-1 for CPU)
#
# @author : Philippe Boutinaud - Fealinx

# ---- New T1+FLAIR models (v2, SavedModel, 5 folds) ----
MODEL_DIR=./T1.FLAIR-WMH
IMAGE_DIR=./images

python ./predict_one_file.py \
    --verbose --gpu 0 --batch_size 1 \
    -m $MODEL_DIR/20241219-171815_ResUnet3D-8.9.2-1.5-T1_FLAIR.WMH_prod2_fold_0_bestvalloss.tf_inference \
    -m $MODEL_DIR/20241219-172156_ResUnet3D-8.9.2-1.5-T1_FLAIR.WMH_prod2_fold_1_bestvalloss.tf_inference \
    -m $MODEL_DIR/20241219-171815_ResUnet3D-8.9.2-1.5-T1_FLAIR.WMH_prod2_fold_2_bestvalloss.tf_inference \
    -m $MODEL_DIR/20241219-172156_ResUnet3D-8.9.2-1.5-T1_FLAIR.WMH_prod2_fold_3_bestvalloss.tf_inference \
    -m $MODEL_DIR/20241219-171815_ResUnet3D-8.9.2-1.5-T1_FLAIR.WMH_prod2_fold_4_bestvalloss.tf_inference \
    -i $IMAGE_DIR/test_T1_Axial_resampled_111_cropped_intensity_normed.nii.gz \
    -i $IMAGE_DIR/test_FLAIR_Axial_resampled_111_cropped_intensity_normed.nii.gz \
    -o ./predicted/test_wmh.nii.gz

# ---- Legacy T1+FLAIR models (v0/v1, .h5, 6 folds) ----
# MODEL_DIR=./WMH/v0/T1-FLAIR.WMH
# python ./predict_one_file.py \
#     --verbose --gpu 0 \
#     -m $MODEL_DIR/20211030-163032_Unet3Dv2-10.7.2-1.8-T1_FLAIR.WMH_fold_1x6_pi_fold_0_model.h5 \
#     -m $MODEL_DIR/20211030-163032_Unet3Dv2-10.7.2-1.8-T1_FLAIR.WMH_fold_1x6_pi_fold_1_model.h5 \
#     -m $MODEL_DIR/20211030-163032_Unet3Dv2-10.7.2-1.8-T1_FLAIR.WMH_fold_1x6_pi_fold_2_model.h5 \
#     -m $MODEL_DIR/20211030-163032_Unet3Dv2-10.7.2-1.8-T1_FLAIR.WMH_fold_1x6_pi_fold_3_model.h5 \
#     -m $MODEL_DIR/20211030-163032_Unet3Dv2-10.7.2-1.8-T1_FLAIR.WMH_fold_1x6_pi_fold_4_model.h5 \
#     -m $MODEL_DIR/20211030-163032_Unet3Dv2-10.7.2-1.8-T1_FLAIR.WMH_fold_1x6_pi_fold_5_model.h5 \
#     -i $IMAGE_DIR/test_T1_Axial_resampled_111_cropped_intensity_normed.nii.gz \
#     -i $IMAGE_DIR/test_FLAIR_Axial_resampled_111_cropped_intensity_normed.nii.gz \
#     -o ./predicted/test_wmh.nii.gz