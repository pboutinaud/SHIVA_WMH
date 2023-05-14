## The segmentation models

* WMH/v0/FLAIR.WMH: is a monomodal segmentation model using only FLAIR modality.
    * due to file size limitation, the models can be found [here](https://cloud.efixia.com/sharing/bOzPqhGiz) : https://cloud.efixia.com/sharing/bOzPqhGiz

The resulting segmentation is an image with voxels values in [0, 1] (proxy for the probability of detection of WMH) that must be thresholded to get the final segmentation. A threshold of 0.2 has been used successfully but that depends on the preferred balance between precision and sensitivity.

