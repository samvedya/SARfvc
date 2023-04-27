%% Polarimetric-Naive Bayes Flood mapping approach 
% DATE OF CREATION OF DOCUMENT: 16/09/2021 
%  AUTHOR: SAMVEDYA SURAMPUDI @Microwave lab, VIT University %%
%%
clc
clear all
%_________________________SECTION-I_______________________________________
% (Reading data and initializing sizes)  
[lulc, flood, p_flood, pol]=read_input();

% Initializing sizes
sz1_fld=size(flood,1);
sz2_fld=size(flood,2);

[l1,l2,l3]=Lc2msk(lulc,4);
% Edit data in the below variables that accurately represents individual features on LULC map
% Each 'l' has only four data cells
% Example  O Figure1 - l1{1,1}
%          O Figure7 - l2{1,3}
%          O Figure10 - l3{1,2}

hyd=l3{1,2};                                            % Water
bul=l2{1,3};                                            % Buildings
veg=l3{1,1};                                            % Vegetation 
wetl=l3{1,4};                                           % wetlands
road=l2{1,4};                                           % Roads
ot=zeros(sz1_fld,sz2_fld);                              
ot(find(hyd==0&bul==0&veg==0&wetl==0&road==0))=1;       % Others

% Mergeing class labels in polarimetric dataset based on LULC
pol=imread('Scat_Mod_Class_georef_fin.tif');
len=1036;
pol=pol(1:len,1:len);

cmap=rand(16,3); \\
figure(1);imshow(pol,[]); colormap (cmap); impixelinfo; % training
% Finding all classes in other than buildings,wetlands and roads area
SOM=ot.*double(pol); %  Others
no_merg=3; % No.of classes to merge \\ CHANGE THIS VALUE TO MERGE MORE OR LESS CLASSES IN Ot \\
i=0;
while i<no_merg
    
    m = mode(SOM(:)); 
    m_list(i+1)=m;
    SOM(SOM==m) = NaN ;
    i=i+1;
end
pol(find(pol==m_list(1)| pol==m_list(2)| pol==m_list(3) ))=m_list(1); % Merge three classes % Here calss 11,0,1- same=11
figure(2)
imshow(pol,[]); colormap (cmap); impixelinfo; 

% \\\\ Buildings, Vegetation, Roads classes are unchanged ?? \\\\
% Fix class labels for buildings, vegetation and roads

lab= unique(pol(:));
pol(find(bul==1))=m_list(2);
pol(find(veg==1))=m_list(3);
pol(find(road==1))=max(lab);

figure(3)
imshow(pol,[]); colormap (cmap); impixelinfo; 


%%
% Labelling the data and visulaization
table(:,1)=flood(:);
table(:,2)=pol(:);
% Spiltting the data into group for each class
cls1=table(table(:,2)==lab(1)); cls2=table(table(:,2)==lab(2));
cls3=table(table(:,2)==lab(3)); cls4=table(table(:,2)==lab(4));
cls5=table(table(:,2)==lab(5)); cls6=table(table(:,2)==lab(6));
cls7=table(table(:,2)==lab(7)); cls8=table(table(:,2)==lab(8));
cls9=table(table(:,2)==lab(9)); cls10=table(table(:,2)==lab(10));
cls11=table(table(:,2)==lab(11)); cls12=table(table(:,2)==lab(12));
cls13=table(table(:,2)==lab(13)); cls14=table(table(:,2)==lab(14));

GMModel = fitgmdist(cls1,2);
cls1_1=cls1(cls1>GMModel.mu(2));
cls1_2=cls1(cls1<GMModel.mu(2));


% Find indices like this using mixture modelling and assign new labelling
% for all  classes
idxgm1=find(cls1>GMModel.mu(2));
