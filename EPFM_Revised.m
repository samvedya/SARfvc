%% Extended probabilistic flood mapping
%  Creating masks from LULC data%%
%  DATE OF CREATION OF DOCUMENT: 16/09/2021 
%  AUTHOR: SAMVEDYA SURAMPUDI @Microwave lab, VIT University %%
%%
lulc=imread('EPFMLulc3Georef.png'); %lulc
imshow(lulc)
area1=imread("FloodHV.tif"); % flood 
area11_cal=(10*(log10(area1.*area1)))-83; % ALOS2 Calibration
area2=imread("PrefloodHV.tif"); % pre flood
area2=area2(1:size(area1,1),1:size(area1,2));
area22_cal=(10*(log10(area2.*area2)))-83; % Calibration
figure(13)
imshow(lulc)

[l1,l2,l3]=Lc2msk(lulc,4);

hyd=l3{1,2}; % Water
imshow(hyd)
bul=l2{1,3};% Buildings
imshow(bul)
veg=l3{1,1};% Vegetation 
imshow(veg)
wetl=l3{1,4}; % wetlands
imshow(wetl)
road=l2{1,4}; % Roads
imshow(road)

SWM=hyd.*area11_cal; % Water
imshow(SWM,[]); impixelinfo; colormap jet;
SBM=bul.*area11_cal; % Buildings
imshow(SBM,[]); impixelinfo; colormap jet;
figure(2); imshow(area11_cal,[])
SVM=veg.*area11_cal; % Vegetation 
imshow(SVM,[]); impixelinfo; colormap jet;
figure(2); imshow(area11_cal,[])
SWeM=wetl.*area11_cal; % wetlands
imshow(SWeM,[]); impixelinfo; colormap jet;
SRM=road.*area11_cal; % Roads
imshow(SRM,[]); impixelinfo; colormap jet;


a11_vec=area11_cal(:); 
a22_vec=area22_cal(:);
F_vec=area22_cal(:);

% Mean SAR masks
Ind_swm=find(SWM(:)); % Indices SWM
swm_m=sum(SWM(:))/(length(Ind_swm)); % Mean SWM

Ind_sbm=find(SBM(:)); % Indices SBM
sbm_m=sum(SBM(:))/(length(Ind_sbm)); % Mean SBM

Ind_svm=find(SVM(:)); % Indices SVM
svm_m=sum(SVM(:))/(length(Ind_svm)); % Mean SVM

Ind_swem=find(SWeM(:)); % Indices SWeM
swem_m=sum(SWeM(:))/(length(Ind_swem)); % Mean SWeM

Ind_srm=find(SRM(:)); % Indices SWeM
srm_m=sum(SRM(:))/(length(Ind_srm)); % Mean SWeM



cls_ini=zeros(length(F_vec),1);
for i=1:length(F_vec)
    if F_vec(i)>= swm_m && F_vec(i)<=swem_m %(btwn -11.69 and -15.22)
        cls_ini(i)=1;
    elseif F_vec(i)>= swem_m && F_vec(i)<=srm_m %(btwn -13.057 and -11.695)
        cls_ini(i)=2;
    elseif F_vec(i)>= srm_m && F_vec(i)<=svm_m%(btwn -17.466 and -13.057)
        cls_ini(i)=3;
    elseif F_vec(i)>= svm_m && F_vec(i)<=sbm_m%(btwn -17.466 and -13.057)
        cls_ini(i)=4;
    elseif F_vec(i)>= sbm_m %(<-15.22)
        cls_ini(i)=5;
   end
end

map1=reshape(cls_ini,size(area1,1),size(area1,2)); 
figure
imshow(map1,[]); colormap jet; impixelinfo;

% Prepare a table
table=[F_vec,cls_ini];
% Spiltting the data into group for each class

cls1=table(table(:,2)==1);
cls2=table(table(:,2)==2);
cls3=table(table(:,2)==3);
cls4=table(table(:,2)==4);
cls5=table(table(:,2)==5);
% Scaling the classes for fitting to distributions

cls1_100=cls1+100;
cls2_100=cls2+100;
cls3_100=cls3+100;
cls4_100=cls4+100;
cls5_100=cls5+100;

% Calculating the priors
priorcls1=length(cls1)/length(table);
priorcls2=length(cls2)/length(table);
priorcls3=length(cls3)/length(table);
priorcls4=length(cls4)/length(table);
priorcls5=length(cls5)/length(table);

% One variable and 5 classes
% Fitting each class to gamma distribution
pdcls1 = fitdist(double(cls1+100),'InverseGaussian');
pdcls2 = fitdist(double(cls2+100),'InverseGaussian');
pdcls3 = fitdist(double(cls3+100),'InverseGaussian');
pdcls4 = fitdist(double(cls4+100),'InverseGaussian');
pdcls5 = fitdist(double(cls5+100),'InverseGaussian');

% Data vector with offset
F_vec100=reF_vec+100;

% Calculation of independent conditional probability

pdf_cls1= pdf('InverseGaussian',cls1+100,pdcls1.mu,pdcls1.lambda); % Gamma distribution
pdf_cls2= pdf('InverseGaussian',cls2+100,pdcls2.mu,pdcls2.lambda); % Gamma distribution
pdf_cls3= pdf('InverseGaussian',cls3+100,pdcls3.mu,pdcls3.lambda); % Gamma distribution
pdf_cls4= pdf('InverseGaussian',cls4+100,pdcls4.mu,pdcls4.lambda); % Gamma distribution
pdf_cls5= pdf('InverseGaussian',cls5+100,pdcls5.mu,pdcls5.lambda); % Gamma distribution

% Prediction
% Independent conditional probability for each class label
% For class label 1
py1=priorcls1.*pdf(pdcls1,F_vec100)*100;
py1=round(py1,2);
% For class label 2
py2=priorcls2.*pdf(pdcls2,F_vec100)*100;
py2=round(py2,2);
% For class label 3
py3=priorcls3.*pdf(pdcls3,F_vec100)*100;
py3=round(py3,2);
% For class label 4
py4=priorcls4.*pdf(pdcls4,F_vec100)*100;
py4=round(py4,2);
% For class label 5
%pdf_cls5(length(pdf_cls5)+1:length(reF_vec),1)=0;
py5=priorcls5.*pdf(pdcls5,F_vec100)*100;
py5=round(py5,2);

% Creating classification map
feature1=py1./(py1+py2+py3+py4+py5);
feature2=py2./(py1+py2+py3+py4+py5);
feature3=py3./(py1+py2+py3+py4+py5);
feature4=py4./(py1+py2+py3+py4+py5);
feature5=py5./(py1+py2+py3+py4+py5);


mm1=reshape(feature1,size(area1,1),size(area1,2));
mm2=reshape(feature2,size(area1,1),size(area1,2));
mm3=reshape(feature3,size(area1,1),size(area1,2));
mm4=reshape(feature4,size(area1,1),size(area1,2));
mm5=reshape(feature5,size(area1,1),size(area1,2));
imshow(mm5,[]); colormap jet;
%([0 0 1; 0 1 0; 0 1 1; 1 0 0; 1 1 0]);
figure(1);imshow(mm1,[]); colormap jet;
figure(2);imshow(mm2,[]); colormap jet;
figure(3);imshow(mm3,[]); colormap jet;
figure(4);imshow(mm4,[]); colormap jet;
figure(5);imshow(mm5,[]); colormap jet;

% New classification with six classes based on probabilities >0.5

c1G5=find(mm1>0.5); % Complete vegetation and urban 6

c1L5=find(mm2>0.5); % Flooded vegetation 3

c2G5=find(mm3>0.5); % 2

c3G5=find(mm4>0.5); % Road and other features 5

c4G5=find(mm5>0.5); % Flood pixels 4
% New class
clasify2=zeros(length(F_vec),1);

clasify2(c1G5)=1; %6 
clasify2(c1L5)=2; %3
clasify2(c2G5)=3; %2
clasify2(c3G5)=4; %5
clasify2(c4G5)=5; %4

newfet2=reshape(clasify2,size(area1,1),size(area1,2));
figure(6);imshow(newfet2,[]); colormap ([1 0 0; 0 1 0; 1 1 0; 1 0 1; 0 1 1; 0 0 1]); impixelinfo; %colormap jet;
figure(6);imshow(newfet2,[]); colormap jet;



figure(2);
CM2=confusionchart(cls_ini,clasify2,'RowSummary','row-normalized','ColumnSummary','column-normalized');
cort=find(swap==new1);
accuracy=(length(cort)/length(swap))*100;
cp = classperf(one,two);








