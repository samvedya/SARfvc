# Probabilistic-Flood-Mapping
> **SAR image classification based on Bayesian Infrence for identification of flooded features**


Extended probabilistic flood inundation mapping method uses Bayesian Inference to classify the Synthetic Aperture Radar images during flood.
This method elimaminates misclassifications during flood mapping in vegetated areas on SAR data. 
Uses LULC derived masks for calculating priors.

**Inputs**

Land Use Land Cover map (LULC)   
SAR images - During Flood, Pre flood

**Outputs**

Classified image with five diffrent flood classess 
	
**Files**

Mask.m - Prior probablities drived from masks for EPFM  
EPFM.m - Extended Probabilistic Flood Mapping 
