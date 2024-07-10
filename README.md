# Face-Annotation

This Matlab implementation provides scripts to facilitate semi-automated, user-supervised face detection and annotation in footage of still images collected via an eyewear-embedded camera. It has been mentioned in the paper:

Kamensek, T., Iarocci, G., & Oruc, I. (2024). *The face diet of adults with autism spectrum disorder*. Current Biology.

If you find "Face-Annotation" useful in your research, please consider citing:

<citation>

## Files

### Detection

- **driver_detectionsASD.m**: Driver script for handling automated face detection in the footage.
- **detections3.m**: Script for automated face detection. This code creates and saves a data structure (`facedetec.mat`) with the same number of entries as images in the footage. It includes unique bounding boxes for each face automatically detected in each image and fields for each bounding box to be populated with various annotations (e.g., gender, pose, ethnicity, etc.).

### Annotation

- **driver_analysisASD.m**: Main driver script for face annotation.
- **analysis4_ASD.m**: Script for user input. This script loads the bounding boxes from `facedetec.mat` and displays them overlaid onto the images via a graphical user interface. The user must confirm (default), erase, or add bounding boxes for all images and save `facedetec1.mat`. All bounding boxes are populated with default values for each field. The user will then confirm (default) or change the annotations. Images in the footage can be annotated in any order, iteratively, and any changes can be saved or reverted to the original.

## Requirements
MATLAB 2021a or later

## Contact

If you have any questions or suggestions, feel free to open an issue or contact [ipor@mail.ubc.ca](mailto:ipor@mail.ubc.ca).
