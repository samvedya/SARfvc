function [layer1,layer2,layer3]= Lc2msk(lulc, nfeat)

% Lc2msk CONVERTS EACH FEATURE IN LULC AS SEPERATE BINARY MASK
% Input LULC map should be RGB image
% nfeat - Specify number of classes in your input LULC map
% The output is three layer cells. Each cell stores features from
% one of the three bands. 
% Masks used in extended probabilistic flood mapping 

% Example1
% img=imread('lulc.tif')
% Lc2msk(img)
% mask1=layer1{1,1}

% Written by Samvedya Surampudi@ VIT University 


nf=nfeat; 
lc=lulc;


B1=lc(:,:,1); % Extract band1 from LULC
count=grouptransform(B1(:),B1(:),@numel); % Counts for each grey level
tab=unique(table(count,B1(:))); tab=table2array(tab);

 for i=1:nf
    layer1{i}=ones(size(lulc,1),size(lulc,2));
    layer1{i}(find(B1~=tab(end-i,2:2)))=0; 
    figure(i)
    imshow(layer1{i})
 end
    

B2=lc(:,:,2); % Extract band1 from LULC
count=grouptransform(B2(:),B2(:),@numel); % Counts for each grey level
tab=unique(table(count,B2(:))); tab=table2array(tab);

 for i=1:nf
    layer2{i}=ones(size(lulc,1),size(lulc,2));
    layer2{i}(find(B2~=tab(end-i,2:2)))=0; 
    figure(i)
    imshow(layer2{i})
 end

 
B3=lc(:,:,3); % Extract band1 from LULC
count=grouptransform(B3(:),B3(:),@numel); % Counts for each grey level
tab=unique(table(count,B3(:))); tab=table2array(tab);

 for i=1:nf
    layer3{i}=ones(size(lulc,1),size(lulc,2));
    layer3{i}(find(B3~=tab(end-i,2:2)))=0; 
    figure(i)
    imshow(layer3{i})
 end

 
end
