# White Matter Hyperintensities (WMH) segmentation with a 3D Unet

This repository contains the trained tensorflow models for the 3D Segmentation of White Matter Hyperintensities (WMH) from multi-modal T1-Weighted + FLAIR MR Images with a 3D U-Shaped Neural Network (U-net) as described in the scientific publication cited below.

![Gif Image](https://github.com/pboutinaud/SHIVA_PVS/blob/main/docs/Images/SHIVA_BrainTools_small2.gif)

## IP, Licencing & Usage

**The inferences created by these models should not be used for clinical purposes.**

The segmentation models in this repository have been registered at the french 'Association de Protection des Programmes' under the number:

[IDDN.FR.001.240030.000.S.P.2022.000.31230](https://secure2.iddn.org/app.server/certificate/?sn=2022240030000&key=60be6d827b1d205888db6c889f308a16ca530f528a95f0e16b8aa3ce5bdb76f1&lang=fr). 

The segmentation models in this repository are provided under the Creative Common Licence [BY-NC-SA](https://creativecommons.org/licenses/by-nc-sa/4.0/).

![Creative Common Licence BY-NC-SA](./docs/logos/by-nc-sa.eu_.png)

## The segmentation models
For mono-modal models, the models were trained with images with a size of 160 × 214 × 176 x 1 voxels. The training was done with images with an isotropic voxel size of 1 × 1 × 1 mm3 and with normalized voxel values in [0, 1] (min-max normalization with the max set to the 99th percentile of the brain voxel values to avoid "hot spots"). The brain is supposed to be centered, the models are trained with and without a brain mask applied on images.

For multi-modal models trained with T1 + FLAIR images, the models were trained with FLAIR images coregistered to the T1 and added as a second channel: 160 × 214 × 176 x 2 voxels.

The segmentation can be computed as the average of the inference of several models (depending on the number of folds used in the training for a particular model). The resulting segmentation is an image with voxels values in [0, 1] (proxy for the probability of detection of WMH) that must be thresholded to get the actual segmentation. A threshold of 0.5 has been used successfully but that depends on the preferred balance between precision and sensitivity.

To access the models :
* **v2/T1+FLAIR-WMH (recommended)**: New multi-modal production models (T1 + FLAIR) based on the ResUnet3D architecture, trained with Keras 3 / TensorFlow ≥ 2.17. Models are stored in TensorFlow SavedModel format (5 folds).
    * Download: [cloud.efixia.com](https://cloud.efixia.com/sharing/cpb3eUvMa)
    * SHA256 checksum : B2FE8D18FC62F4B1A447F0EF571781CF7656D808BD76A28C4B0CF53BDD391E3B
    * JSON file for SHiVAi pipeline: [model_info_t1-flair-wmh-v2.json](model_info_t1-flair-wmh-v2.json)

* v1/T1-FLAIR.WMH: is a multimodal segmentation model based on v0 and trained with more images from other datasets.
    * due to file size limitation, the models can be found [here](https://cloud.efixia.com/sharing/jxHpYIJQB) : https://cloud.efixia.com/sharing/jxHpYIJQB
    * MD5 checksum : a5523d7d3a8f8adde95c2baf73518afb
    * JSON file for SHiVAi pipeline: [model_info_t1-flair-wmh-v1.json](model_info_t1-flair-wmh-v1.json)

* v0/T1-FLAIR.WMH: is a multimodal segmentation model described in the publication.
    * due to file size limitation, the models can be found [here](https://cloud.efixia.com/sharing/Tq8LqpCbc) : https://cloud.efixia.com/sharing/Tq8LqpCbc
    * MD5 checksum : a371a14c641305ab81efb21545623fbf
    * JSON file for SHiVAi pipeline: [model_info_t1-flair-wmh-v0.json](model_info_t1-flair-wmh-v0.json)

* v0/FLAIR.WMH: is a monomodal segmentation model using only FLAIR modality.
    * due to file size limitation, the models can be found [here](https://cloud.efixia.com/sharing/bOzPqhGiz) : https://cloud.efixia.com/sharing/bOzPqhGiz
    * MD5 checksum : 63602474fa62af1c83efabefd0bd0c79
    * JSON file for SHiVAi pipeline: [model_info_flair-wmh.json](model_info_flair-wmh.json)

## Requirements

### For new models (v2, SavedModel format)
The models require TensorFlow ≥ 2.17 and were tested with Python 3.12 and TensorFlow 2.20. They are stored in the TensorFlow SavedModel format. A NVIDIA GPU with at least 9 GB of VRAM is recommended for inference (CPU inference is also supported but slower).

### For legacy models (v0/v1, H5 format)
The models were trained with TensorFlow ≥ 2.7 and Python 3.7, stored in H5 format. Loading with newer Python/TensorFlow requires the `tf-keras` compatibility package and `TF_USE_LEGACY_KERAS=1`. On CPU, models using mixed_float16 are automatically rebuilt in float32.

### Python dependencies
To run the `predict_one_file.py` script, you will need a python environment with the following libraries:
- tensorflow >= 2.17 (for new models) or tensorflow >= 2.7 (for legacy models)
- numpy
- nibabel
- tf-keras (only needed for legacy .h5 models)

If you don't know anything about python environment and libraries, you can find some documentation and installers on the [Anaconda website](https://docs.anaconda.com/). We recommend using the lightweight [Miniconda](https://docs.anaconda.com/miniconda/).

## Usage
**These models can be used with the [SHiVAi](https://github.com/pboutinaud/SHiVAi) preprocessing and deep learning segmentation workflow.**

### Step-by-step process to run the model without SHiVAi
1. Download the `predict_one_file.py` from the repository (clic the "<> Code" button on the GitHub interface and download the zip file, or clone the repository)
2. Download and unzip the trained models (see [above](#the-segmentation-models))
3. Preprocess the input data (swi or T2gre images) to the proper x-y-z volume (160 × 214 × 176). If the resolution is close to 1mm isotropic voxels, a simple cropping is enough. Otherwise, you will have to resample the images to 1mm isotropic voxels. For now, you will have to do it by yourself, but soon we will provide a full Shiva pipeline to run everything.
4. Run the `predict_one_file.py` script as described below


To run `predict_one_file.py` in your python environment you can check the help with the command `python predict_one_file.py -h` (replace "predict_one_file.py" with the full path to the script if it is not in the working directory).
Here is an example of usage of the script with the new SavedModel models:
- The `predict_one_file.py` script stored in `/myhome/my_scripts/`
- Preprocessed Nifti images (volume shape must be 160 × 214 × 176 and voxel values between 0 and 1) stored (for the example) in the folder `/myhome/mydata/`
- The WMH AI models stored (for the example) in `/myhome/wmh_models/v2`
- The ouput folder (for the example) `/myhome/my_results` needs to exist at launch

```bash
# New T1+FLAIR SavedModel models (v2, recommended)
python /myhome/my_scripts/predict_one_file.py \
    -i /myhome/mydata/t1_image.nii.gz \
    -i /myhome/mydata/flair_image.nii.gz \
    -b /myhome/mydata/input_brainmask.nii.gz \
    -o /myhome/my_results/wmh_segmentation.nii.gz \
    --batch_size 1 --gpu 0 \
    -m /myhome/wmh_models/v2/20241219-171815_ResUnet3D-8.9.2-1.5-T1_FLAIR.WMH_prod2_fold_0_bestvalloss.tf_inference \
    -m /myhome/wmh_models/v2/20241219-172156_ResUnet3D-8.9.2-1.5-T1_FLAIR.WMH_prod2_fold_1_bestvalloss.tf_inference \
    -m /myhome/wmh_models/v2/20241219-171815_ResUnet3D-8.9.2-1.5-T1_FLAIR.WMH_prod2_fold_2_bestvalloss.tf_inference \
    -m /myhome/wmh_models/v2/20241219-172156_ResUnet3D-8.9.2-1.5-T1_FLAIR.WMH_prod2_fold_3_bestvalloss.tf_inference \
    -m /myhome/wmh_models/v2/20241219-171815_ResUnet3D-8.9.2-1.5-T1_FLAIR.WMH_prod2_fold_4_bestvalloss.tf_inference
```
>Note that the brain mask input here with `-b /myhome/mydata/input_brainmask.nii.gz` is optional

```bash
# Legacy T1+FLAIR H5 models (v1)
python /myhome/my_scripts/predict_one_file.py \
    -i /myhome/mydata/t1_image.nii.gz \
    -i /myhome/mydata/flair_image.nii.gz \
    -b /myhome/mydata/input_brainmask.nii.gz \
    -o /myhome/my_results/wmh_segmentation.nii.gz \
    --gpu 0 \
    -m /myhome/wmh_models/v1/WMH_fold_0_model.h5 \
    -m /myhome/wmh_models/v1/WMH_fold_1_model.h5 \
    -m /myhome/wmh_models/v1/WMH_fold_2_model.h5
```
>Note that the brain mask input here with `-b /myhome/mydata/input_brainmask.nii.gz` is optional

### Building your own script
The provided python script `predict_one_file.py` can be used as is for running the model or can be used an example to build your own script.


Here is the main part of the script for new SavedModel models, assuming that the images are in a numpy array with the correct shape (*nb of images*, 160, 214, 176, *number of modality to use for this model*):
````python
import tensorflow as tf
import numpy as np

# Load models & predict
predictions = []
for model_dir in model_dirs:  # model_dirs is the list of SavedModel directory paths
    model = tf.saved_model.load(model_dir)
    batch = tf.constant(images, dtype=tf.float32)
    prediction = model.serve(batch).numpy()
    predictions.append(prediction)

# Average all predictions
predictions = np.mean(predictions, axis=0)
````

For legacy .h5 models (requires `tf-keras` and `TF_USE_LEGACY_KERAS=1`):
````python
import os
os.environ["TF_USE_LEGACY_KERAS"] = "1"
import tensorflow as tf
import numpy as np

predictions = []
for predictor_file in predictor_files:
    tf.keras.backend.clear_session()
    model = tf.keras.models.load_model(predictor_file, compile=False, custom_objects={"tf": tf})
    prediction = model.predict(images)
    predictions.append(prediction)

predictions = np.mean(predictions, axis=0)
````

## Acknowledgements
This work has been done in collaboration between the [Fealinx](http://www.fealinx-biomedical.com/en/) company and the [GIN](https://www.gin.cnrs.fr/en/) laboratory (Groupe d'Imagerie Neurofonctionelle, UMR5293, IMN, Univ. Bordeaux, CEA , CNRS) with grants from the Agence Nationale de la Recherche (ANR) with the projects [GinesisLab](http://www.ginesislab.fr/) (ANR 16-LCV2-0006-01) and [SHIVA](https://rhu-shiva.com/en/) (ANR-18-RHUS-0002)

|<img src="./docs/logos/shiva_blue.png" width="100" height="100" />|<img src="./docs/logos/fealinx.jpg" height="200" />|<img src="./docs/logos/Logo-Gin.png" height="200" />|<img src="./docs/logos/logo_ginesis-1.jpeg" height="100" />|<img src="./docs/logos/logo_anr.png" height="50" />|
|---|---|---|---|---|


## Abstract

White matter hyperintensities (WMHs) are well-established markers of cerebral small vessel disease (cSVD), and associated with increased risk of stroke, dementia, and mortality (Debette & Markus 2010). Although their prevalence increases with age, small and punctate WMHs have been reported with surprisingly high frequency even in young, neurologically asymptomatic adults under 40 years of age (Keřkovský et al. 2019; Williamson et al. 2018). In order to study the emergence of WMHs and their progression throughout the adult lifespan, it is critical to have tools that can automatically segment and quantify both small and large WMHs accurately. However, most automatic methods published to date are optimised for detection in older subjects or patients with multiple sclerosis, who typically manifest a higher load of large WMHs. Here, we present a deep-learning (DL) based algorithm that can be used to segment WMHs across a range of severity, including small WMH found in younger subjects.

## Publication
http://doi.org/10.1002/hbm.26548 
```
Tsuchida, A., V. Verrecchia, P. Boutinaud, S. Debette, C. Tzourio and M. Joliot (2022). Early detection of white matter hyperintensities using SHIVA-WMH detector. Organization of Human Brain Mapping, Glasgow.
```
