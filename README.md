# White Matter Hyperintensities (WMH) segmentation with a 3D Unet

This repository contains the trained tensorflow models for the 3D Segmentation of White Matter Hyperintensities (WMH) from multi-modal T1-Weighted + FLAIR MR Images with a 3D U-Shaped Neural Network (U-net) as described in the scientific publication cited below.

## IP, Licencing & Usage

**The inferences created by these models should not be used for clinical purposes.**

The segmentation models in this repository have been registered at the french 'Association de Protection des Programmes' under the number:

[IDDN.FR.001.240030.000.S.P.2022.000.31230](https://secure2.iddn.org/app.server/certificate/?sn=2022240030000&key=60be6d827b1d205888db6c889f308a16ca530f528a95f0e16b8aa3ce5bdb76f1&lang=fr). 

The segmentation models in this repository are provided under the Creative Common Licence [BY-NC-SA](https://creativecommons.org/licenses/by-nc-sa/4.0/).

![Creative Common Licence BY-NC-SA](./docs/logos/by-nc-sa.eu_.png)

## The segmentation models
For mono-modal models, the models were trained with images with a size of 160 × 214 × 176 x 1 voxels. The training was done with images with an isotropic voxel size of 1 × 1 × 1 mm3 and with normalized voxel values in [0, 1] (min-max normalization with the max set to the 99th percentile of the brain voxel values to avoid "hot spots"). The brain is supposed to be centered, the models are trained with and without a brain mask applied on images.

For multi-modal models trained with T1 + FLAIR images, the models were trained with FLAIR images coregistered to the T1 and added as a second channel: 160 × 214 × 176 x 2 voxels.

A segmentation can be computed as the average of the inference of several models (depending on the number of folds used in the training for a particular model), the provided models can be found in the directories:

* WMH/v1/T1-FLAIR.WMH: is a multimodal segmentation model based on v0 and trained with more images from other datasets.
    * due to file size limitation, the models can be found [here](https://cloud.efixia.com/sharing/jxHpYIJQB) : https://cloud.efixia.com/sharing/jxHpYIJQB
    * Checksum : a5523d7d3a8f8adde95c2baf73518afb

* WMH/v0/T1-FLAIR.WMH: is a multimodal segmentation model described in the publication.
    * due to file size limitation, the models can be found [here](https://cloud.efixia.com/sharing/Tq8LqpCbc) : https://cloud.efixia.com/sharing/Tq8LqpCbc
    * Checksum : a371a14c641305ab81efb21545623fbf
* WMH/v0/FLAIR.WMH: is a monomodal segmentation model using only FLAIR modality.
    * due to file size limitation, the models can be found [here](https://cloud.efixia.com/sharing/bOzPqhGiz) : https://cloud.efixia.com/sharing/bOzPqhGiz
    * Checksum : 63602474fa62af1c83efabefd0bd0c79

The resulting segmentation is an image with voxels values in [0, 1] (proxy for the probability of detection of WMH) that must be thresholded to get the final segmentation. A threshold of 0.5 has been used successfully but that depends on the preferred balance between precision and sensitivity.

## Requirements
The models were trained with Tensorflow >= 2.7 used with Python 3.7, they are stored in the H5 format (there is a compatibility problem when reading tensorflow H5 files by using Python version > 3.7).

The provided python script *predict_one_file.py* can be used as an example of usage of the model. It needs the *nibabel* python library to be able to read NIfTI files. 

A NVIDIA GPU with at least 9Go of RAM is needed to compute inferences with the trained models.

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
