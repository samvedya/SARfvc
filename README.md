# About 
<p align="justify">Flood mapping using Synthetic Aperture Radar data impose limitations in fully distinguishing flood under vegetation due to false double bounce returns from inundated tree trunks along with seasonal heterogeneities devised from changing land cover settings. SARfvcVer1 (SAR Flood Vegetation Classifier version-1) is a fully automatic supervised classification tool that uses hybrid Naïve Bayes classifier and is used to detect various flooded vegetation classes. The tool eliminates ROI selection step. It incorporates polarimetric information/LULC in labelling the image. It works best in identifying floods in agricultural lands and forests.  </p>

# Installation 

### Prerequisites for Deployment 

Verify that version 9.10 (R2021a) of the MATLAB Runtime is installed.   
If not, you can run the MATLAB Runtime installer.
To find its location, enter  `` >> mcrinstaller `` at the MATLAB prompt.
>[!NOTE]
>You will need administrator rights to run the MATLAB Runtime installer.

Alternatively, download and install the Windows version of the MATLAB Runtime for R2021a 
from the link on the [MathWorks website](https://www.mathworks.com/products/compiler/mcr/index.html)

### Files to Deploy and Package
- SARFvc_Ver1.exe  
- MCRInstaller.exe

# Using the tool 
**STEP 1:**  Downlaod the installer "_SARFvc_Ver1.exe_" from [for_redistribution_files](https://github.com/samvedya/SARfvc/tree/main/for_redistribution_files) folder in this page. Make sure you have the following inputs. Example datasets are included in the folder
>
> |    Inputs                         |         Data         |      Name of example data      |
> |:---------------------------------:|:--------------------:|:------------------------------:|
> |Classified PolSAR image [procedure](https://eo4society.esa.int/wp-content/uploads/2021/01/2015_3rdPolarimetry_PolSAR_Practical_EPottier.pdf)|    Any season        |   Scat_Mod_Class_georef_fin    |
> |Single band SAR image during flood |Image to be classified|         FloodHV                |
> |       LULC                        |    Optional          |      LULC_georef               |
>
> Note: All the images must be georeferenced 

**STEP 2:** Follow all the prerequisites   
**STEP 3:** If you run the executable with exisitng MATLAB in your system, set the path to your data folder.   
**STEP 4:** When you run the program it prompts for data as shown below. Select your folder and upload the data in order.

