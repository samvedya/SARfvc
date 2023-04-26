# SAR-Flood-Mapping
> **SAR image classification based on Bayesian Infrence for identification of flooded features**


Extended probabilistic flood inundation mapping method uses Bayesian Inference to classify the Synthetic Aperture Radar images during flood.
This method elimaminates misclassifications during flood mapping in vegetated areas on SAR data. 
Uses LULC derived masks for calculating priors.  
This repository contains three file.  
- EPFM.m - the main file which does the classification  
- Lc2msk - Function gives binary masks for each feature from LULC required for EPFM.m
- Mask.m - Allows to create your own ROI from LULC

**Inputs**

Land Use Land Cover map (LULC)   
SAR images - During Flood, Pre flood

**Outputs**

Classified image with five diffrent flood classess 
	

