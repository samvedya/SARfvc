function [lulc, flood, p_flood, pol]=read_input()

% Input images should be entered in the order 
% - LULC
% - SAR flood image
% - SAR pre-flood image
% - Scattering model based classified (POLSAR) image

% (C)Samvedya Surampudi@ VIT University 

disp('Select data folder..............................')
path=uigetdir('D:\');
% Reading LULC image
disp('Select georeferenced LULC image..................')
[a, path] = uigetfile(fullfile(path,'*.*')) ;
% Reading SAR flood data
disp('Select SAR flood image..................')
[b, path] = uigetfile(fullfile(path,'*.*')) ;
% Reading SAR flood data
disp('Select SAR pre-flood image ..................')
[c, path] = uigetfile(fullfile(path,'*.*')) ;
% Reading SAR flood data
disp('Select georeferenced POLSAR classified image..................')
[d, path] = uigetfile(fullfile(path,'*.*')) ;



a = imread(a);                                           % LULC
b = imread(b);                                           % SAR flood 
b = medfilt2(b);                                         % Speckle filtering
flood=(10*(log10(b.*b)))-83;                             % ALOS2 Calibration
flood(flood==-inf)=mean(flood(find(flood~=-inf))); 
c=imread(c);                                             % SAR Pre-flood
c=medfilt2(c);                                           % Speckle filtering
p_flood=(10*(log10(c.*c)))-83;                           % ALOS2 Calibration
p_flood(p_flood==-inf)=mean(p_flood(find(p_flood~=-inf)));                                                                 
pol=imread(d); pol=double(pol);                          % Scattering model based classification

% Equilizing dimensions of all data sets
if (size(flood,1)<size(flood,2))
    len=size(flood,1);
else
    len=size(flood,2);
end

lulc(:,:,1)=a(:,:,1);lulc(:,:,2)=a(:,:,2);lulc(:,:,3)=a(:,:,3);
lulc=lulc(1:len,1:len,:);
flood=flood(1:len,1:len);
p_flood=p_flood(1:len,1:len);
pol=pol(1:len,1:len);


% Display images
figure(1); imshow(lulc,[]);
figure(2); imshow(flood,[]);
figure(3); imshow(p_flood,[]);
figure(4); cmap=rand(16,3);imshow(pol,[]); colormap (cmap); impixelinfo


end

