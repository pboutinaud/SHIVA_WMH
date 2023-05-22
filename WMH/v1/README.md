## The segmentation models

* WMH/v1/T1-FLAIR.WMH: is a multimodal segmentation model based on v0 and trained with more images from other datasets.
    * due to file size limitation, the models can be found [here](https://cloud.efixia.com/sharing/jxHpYIJQB) : https://cloud.efixia.com/sharing/jxHpYIJQB

The resulting segmentation is an image with voxels values in [0, 1] (proxy for the probability of detection of WMH) that must be thresholded to get the final segmentation. A threshold of 0.5 has been used successfully but that depends on the preferred balance between precision and sensitivity.

