%% Extended probabilistic flood mapping
%  Creating masks from LULC data%%
%  DATE OF CREATION OF DOCUMENT: 16/09/2021 
%  AUTHOR: SAMVEDYA SURAMPUDI @Microwave lab, VIT University %%
%%
lulc=imread('EPFMLulc3Georef.png'); %lulc
imshow(lulc)
area1=imread("FloodHV.tif"); % flood 
area1= medfilt2(area1);
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

% Count of number of pixels corresponding to feature from each mask
hyd_cnt=length(find(hyd==1));
bul_cnt=length(find(bul==1));
veg_cnt=length(find(veg==1));
wetl_cnt=length(find(wetl==1));
road_cnt=length(find(road==1));
ot_cnt=(size(hyd,1)*size(hyd,2))-(hyd_cnt+bul_cnt+veg_cnt+wetl_cnt+road_cnt);

% Calculating priors corresponding to each mask
pr_hyd=hyd_cnt/(size(hyd,1)*size(hyd,2));
pr_bul=bul_cnt/(size(bul,1)*size(bul,2));
pr_veg=veg_cnt/(size(veg,1)*size(veg,2));
pr_wetl=wetl_cnt/(size(wetl,1)*size(wetl,2));
pr_road=road_cnt/(size(road,1)*size(road,2));
pr_ot=ot_cnt/((size(hyd,1)*size(hyd,2))); % or prior flood?

cls_ini=zeros(length(F_vec),1); % New 
cls_fin=zeros(length(F_vec),1);

hyd_sar=area11_cal(find(hyd==1)); 
% Replacing -inf values with the mean value
hyd_sar(hyd_sar==-inf)=mean(hyd_sar(find(hyd_sar~=-inf))); 
bul_sar=area11_cal(find(bul==1));
bul_sar(bul_sar==-inf)=mean(bul_sar(find(bul_sar~=-inf))); 
veg_sar=area11_cal(find(veg==1));
veg_sar(veg_sar==-inf)=mean(veg_sar(find(veg_sar~=-inf))); 
wetl_sar=area11_cal(find(wetl==1));
wetl_sar(wetl_sar==-inf)=mean(wetl_sar(find(wetl_sar~=-inf))); 
road_sar=area11_cal(find(road==1));
road_sar(road_sar==-inf)=mean(road_sar(find(road_sar~=-inf))); 
ot_sar=area11_cal(find(hyd==0&bul==0&veg==0&wetl==0&road==0));
ot_sar(ot_sar==-inf)=mean(ot_sar(find(ot_sar~=-inf))); 

mode(hyd_sar)
mode(bul_sar)
mode(veg_sar)
mode(wetl_sar)
mode(road_sar)
mode(ot_sar)



% Imp
cls_ini(find(hyd==1))=hyd_sar;
cls_ini(find(bul==1))=bul_sar;
cls_ini(find(veg==1))=veg_sar;
cls_ini(find(wetl==1))=wetl_sar;
cls_ini(find(road==1))=road_sar;
cls_ini(find(cls_ini==0))=ot_sar;


cls_fin(find(hyd==1))=1; % 1==hyd
cls_fin(find(bul==1))=2; % 2==bul
cls_fin(find(veg==1))=3; % 3==veg
cls_fin(find(wetl==1))=4;% 4==wetl
cls_fin(find(road==1))=5;% 5==road 
cls_fin(find(cls_fin==0))=6;% 6==others
map1=reshape(cls_ini,size(area1,1),size(area1,2)); 
figure
imshow(map1,[]); impixelinfo;
colormap jet; impixelinfo;


map1=reshape(cls_fin,size(area1,1),size(area1,2)); 
figure
imshow(map1,[]); impixelinfo;
colormap jet; impixelinfo;


figure(2)
color = lines(6);


g={wetl_sar(1:100),veg_sar(1:100)};
figure(1)
gscatter(wetl_sar(1:100),veg_sar(1:100),g,color(1:2,:),'.',30,'off');

g1={hyd_sar(1:100),bul_sar(1:100)};
figure(2)
gscatter(hyd_sar(1:100),bul_sar(1:100),g1,color(1:2,:),'.',30,'off');

g2={ot_sar(1:100),road_sar(1:100)};
figure(3)
gscatter(ot_sar(1:100),road_sar(1:100),g2,color(1:2,:),'.',30,'off');

g3={hyd_sar(1:100),veg_sar(1:100)};
figure(4)
gscatter(hyd_sar(1:100),veg_sar(1:100),g3,color(1:2,:),'.',30,'off');


%gscatter(hyd_sar(1:100),bul_sar(1:100),g,'rbmk','^os*',9,'off')

%%
tst
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
F_vec=area11_cal(:);

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
table=[F_vec,cls_fin];
% Spiltting the data into group for each class

cls1=table(table(:,2)==1);
cls2=table(table(:,2)==2);
cls3=table(table(:,2)==3);
cls4=table(table(:,2)==4);
cls5=table(table(:,2)==5);
cls6=table(table(:,2)==6);
% Scaling the classes for fitting to distributions

cls1_100=cls1+100;
cls2_100=cls2+100;
cls3_100=cls3+100;
cls4_100=cls4+100;
cls5_100=cls5+100;
cls6_100=cls6+100;

% Calculating the priors
priorcls1=length(cls1)/length(table);
priorcls2=length(cls2)/length(table);
priorcls3=length(cls3)/length(table);
priorcls4=length(cls4)/length(table);
priorcls5=length(cls5)/length(table);
priorcls6=length(cls6)/length(table);

% One variable and 5 classes
% Fitting each class to gamma distribution
pdcls1 = fitdist(double(cls1+100),'InverseGaussian');
pdcls2 = fitdist(double(cls2+100),'InverseGaussian');
pdcls3 = fitdist(double(cls3+100),'InverseGaussian');
pdcls4 = fitdist(double(cls4+100),'InverseGaussian');
pdcls5 = fitdist(double(cls5+100),'InverseGaussian');
pdcls6 = fitdist(double(cls6+100),'InverseGaussian');


% Data vector with offset
F_vec100=reF_vec+100;

% Calculation of independent conditional probability

pdf_cls1= pdf('InverseGaussian',cls1+100,pdcls1.mu,pdcls1.lambda); % Gamma distribution
pdf_cls2= pdf('InverseGaussian',cls2+100,pdcls2.mu,pdcls2.lambda); % Gamma distribution
pdf_cls3= pdf('InverseGaussian',cls3+100,pdcls3.mu,pdcls3.lambda); % Gamma distribution
pdf_cls4= pdf('InverseGaussian',cls4+100,pdcls4.mu,pdcls4.lambda); % Gamma distribution
pdf_cls5= pdf('InverseGaussian',cls5+100,pdcls5.mu,pdcls5.lambda); % Gamma distribution
pdf_cls6= pdf('InverseGaussian',cls6+100,pdcls5.mu,pdcls6.lambda); % Gamma distribution



% Prediction
% Independent conditional probability for each class label
% For class label 1

%1==hyd
py1=pr_hyd.*pdf(pdcls1,F_vec100)*100;
py1=round(py1,2);

% 2==bul
% For class label 2
py2=pr_bul.*pdf(pdcls2,F_vec100)*100;
py2=round(py2,2);

% 3==veg
% For class label 3
py3=pr_veg.*pdf(pdcls3,F_vec100)*100;
py3=round(py3,2);

% 4==wetl
% For class label 4
py4=pr_wetl.*pdf(pdcls4,F_vec100)*100;
py4=round(py4,2);

% 5==road 
% For class label 5
py5=pr_road.*pdf(pdcls5,F_vec100)*100;
py5=round(py5,2);

% 6==others
% For class label 6
py6=pr_ot.*pdf(pdcls6,F_vec100)*100;
py6=round(py6,2);



% Creating classification map
feature1=py1./(py1+py2+py3+py4+py5+py6);
feature2=py2./(py1+py2+py3+py4+py5+py6);
feature3=py3./(py1+py2+py3+py4+py5+py6);
feature4=py4./(py1+py2+py3+py4+py5+py6);
feature5=py5./(py1+py2+py3+py4+py5+py6);
feature6=py6./(py1+py2+py3+py4+py5+py6);


mm1=reshape(feature1,size(area1,1),size(area1,2));
mm2=reshape(feature2,size(area1,1),size(area1,2));
mm3=reshape(feature3,size(area1,1),size(area1,2));
mm4=reshape(feature4,size(area1,1),size(area1,2));
mm5=reshape(feature5,size(area1,1),size(area1,2));
mm6=reshape(feature6,size(area1,1),size(area1,2));

imshow(mm6,[]); colormap jet;
%([0 0 1; 0 1 0; 0 1 1; 1 0 0; 1 1 0]);
figure(1);imshow(mm1,[]); colormap jet;
figure(2);imshow(mm2,[]); colormap jet;
figure(3);imshow(mm3,[]); colormap jet;
figure(4);imshow(mm4,[]); colormap jet;
figure(5);imshow(mm5,[]); colormap jet;
figure(6);imshow(mm6,[]); colormap jet;


% New classification with six classes based on probabilities >0.5

c1G5=find(mm1>0.5); % Complete vegetation and urban 6

c1L5=find(mm2>0.5); % Flooded vegetation 3

c2G5=find(mm3>0.5); % 2

c3G5=find(mm4>0.5); % Road and other features 5 

c4G5=find(mm5>0.5); % Flood pixels 4
c5G5=find(mm6>0.5); % Flood pixels 4
% New class
clasify2=zeros(length(F_vec),1);

clasify2(c1G5)=1; %6 
clasify2(c1L5)=2; %3
clasify2(c2G5)=3; %2
clasify2(c3G5)=4; %5
clasify2(c4G5)=5; %4
clasify2(c5G5)=6; %4

newfet2=reshape(clasify2,size(area1,1),size(area1,2));
figure(6);imshow(newfet2,[]);
colormap ([1 0 0; 0 1 0; 1 1 0; 1 0 1; 0 1 1; 0 0 1]); impixelinfo; %colormap jet;
figure(6);imshow(newfet2,[]); colormap jet;



figure(2);
CM2=confusionchart(cls_fin,clasify2,'RowSummary','row-normalized','ColumnSummary','column-normalized');
cort=find(swap==new1);
accuracy=(length(cort)/length(swap))*100;
cp = classperf(one,two);


