%% 
%  Extended probabilistic flood mapping
%  Deleniation of flood from SAR data%%
%  DATE OF CREATION OF DOCUMENT: 16/09/2021 
%  AUTHOR: SAMVEDYA SURAMPUDI @Microwave lab, VIT University %%
%%

% Reading SAR images

area11=imread("subset_4_of_ALOS2-FBDR2_1GUA-ORBIT__ALOS2095460510-160228_Spk.tif"); % pre flood 
area11_cal=(10*(log10(area11.*area11)))-83; % ALOS2 Calibration
area11_nfld=area11_cal(1:1024,1:1024);
area22=imread("subset_6_of_ALOS2-FBDR2_1GUA-ORBIT__ALOS2118230510-160731_Spk.tif"); %  flood
area22_cal=(10*(log10(area22.*area22)))-83; % ALOS2 Calibration
area22_fld=area22_cal(1:1024,1:1024);

v1=area11_nfld(:); 
v2=area22_fld(:);
reF_vec=area22_fld(:);


retst1=area22_fld.*BWM;
retst1_vec=retst1(:);
reIndt1=find(retst1_vec);
rem1=sum(retst1_vec)/(length(reIndt1));


retst2=area22_fld.*BVM;
retst2_vec=retst2(:);
reIndt2=find(retst2_vec);
rem2=sum(retst2_vec)/(length(reIndt2));


retst3=area22_fld.*BBM1;
retst3_vec=retst3(:);
reIndt3=find(retst3_vec);
rem3=sum(retst3_vec)/(length(reIndt3));
% Note: Trpeat the means by taking area11_nfld and area22_fld to get the
% tresholds

rem4=-15.22;
% Note: Replace any zeros in the table by 1

new1=zeros(length(f_vec),1);
for i=1:length(f_vec)
    if reF_vec(i)>= rem2 && reF_vec(i)<=rem4 %(btwn -11.69 and -15.22)
        new1(i)=1;
    elseif reF_vec(i)>= rem3 && reF_vec(i)<=rem2 %(btwn -13.057 and -11.695)
        new1(i)=2;
    elseif reF_vec(i)>= rem1 && reF_vec(i)<=rem3 %(btwn -17.466 and -13.057)
        new1(i)=3;
    elseif reF_vec(i)<= rem4 %(<-15.22)
        new1(i)=4;
    elseif reF_vec(i)>= rem2 && reF_vec(i)<=-9 %(btwn -9and -11.6957)
        new1(i)=5;
    end
end

map2=reshape(new1,1024,1024); 
new1(new1==0)=1;
imshow(map2,[]); colormap jet; impixelinfo;

% Prepare a table
table=[reF_vec,new1];

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
% Fitting each class to inverse guassian distribution
pdcls1 = fitdist(double(cls1+100),'InverseGaussian');
pdcls2 = fitdist(double(cls2+100),'InverseGaussian');
pdcls3 = fitdist(double(cls3+100),'InverseGaussian');
pdcls4 = fitdist(double(cls4+100),'InverseGaussian');
pdcls5 = fitdist(double(cls5+100),'InverseGaussian');

% Data vector with offset
reF_vec100=reF_vec+100;

% Calculation of independent conditional probability

pdf_cls1= pdf('InverseGaussian',cls1+100,pdcls1.mu,pdcls1.lambda); 
pdf_cls2= pdf('InverseGaussian',cls2+100,pdcls2.mu,pdcls2.lambda); 
pdf_cls3= pdf('InverseGaussian',cls3+100,pdcls3.mu,pdcls3.lambda); 
pdf_cls4= pdf('InverseGaussian',cls4+100,pdcls4.mu,pdcls4.lambda); 
pdf_cls5= pdf('InverseGaussian',cls5+100,pdcls5.mu,pdcls5.lambda); 

% Prediction
% Independent conditional probability for each class label
% For class label 1
py1=priorcls1.*pdf(pdcls1,reF_vec100)*100;
py1=round(py1,2);
% For class label 2
py2=priorcls2.*pdf(pdcls2,reF_vec100)*100;
py2=round(py2,2);
% For class label 3
py3=priorcls3.*pdf(pdcls3,reF_vec100)*100;
py3=round(py3,2);
% For class label 4
py4=priorcls4.*pdf(pdcls4,reF_vec100)*100;
py4=round(py4,2);
% For class label 5
%pdf_cls5(length(pdf_cls5)+1:length(reF_vec),1)=0;
py5=priorcls5.*pdf(pdcls5,reF_vec100)*100;
py5=round(py5,2);

% For diffferent algorithm (Probabilistic mapping)accuracy testing with priors 0.5

pdcls1 = fitdist(double(area22_fld(:)+100),'InverseGaussian');

py11=0.5.*pdf(pdcls1,reF_vec100)*100;
py11=round(py11,2);
py11=reshape(py11,1024,1024);

py22=0.5.*pdf(pdcls1,reF_vec100)*100;
py22=round(py22,2);
py22=reshape(py22,1024,1024);

imshow(py22,[]); colormap jet;
feature11=py11./(py11+py22);
%%
% Creating classification map
feature1=py1./(py1+py2+py3+py4+py5);
feature2=py2./(py1+py2+py3+py4+py5);
feature3=py3./(py1+py2+py3+py4+py5);
feature4=py4./(py1+py2+py3+py4+py5);
feature5=py5./(py1+py2+py3+py4+py5);

mm1=reshape(feature1,1024,1024);
mm2=reshape(feature2,1024,1024);
mm3=reshape(feature3,1024,1024);
mm4=reshape(feature4,1024,1024);
mm5=reshape(feature5,1024,1024);
imshow(mm5,[]); colormap jet;
%([0 0 1; 0 1 0; 0 1 1; 1 0 0; 1 1 0]);
figure(1);imshow(mm1,[]); colormap jet;
figure(2);imshow(mm2,[]); colormap jet;
figure(3);imshow(mm3,[]); colormap jet;
figure(4);imshow(mm4,[]); colormap jet;
figure(5);imshow(mm5,[]); colormap jet;

% New classification with six classes based on probabilities >0.5

c1G5=find(norm1>0.7); % Complete vegetation and urban 6

c1L5=find(norm1>0.3 & norm1< 0.5); % Flooded vegetation 3

c2G5=find(norm2>0.5); % 2

c3G5=find(norm3>0.5); % Road and other features 5

c4G5=find(norm4>0.1); % Flood pixels 4

c5G5= find(norm5>0.5);%find(norm5<0.5 & norm5>0.3); 1

% Rearrrranging classes
clasify2=zeros(length(reF_vec),1);

clasify2(c1G5)=1; %6 
clasify2(c1L5)=2; %3

clasify2(c2G5)=3; %2

clasify2(c3G5)=4; %5

clasify2(c4G5)=5; %4
clasify2(clasify2==6)=2; %2
clasify2(c5G5)=6; % 1

% Display map

newfet2=reshape(clasify2,1024,1024);
figure(6);imshow(newfet2,[]); colormap ([1 0 0; 0 1 0; 1 1 0; 1 0 1; 0 1 1; 0 0 1]); impixelinfo; %colormap jet;
figure(6);imshow(newfet2,[]); colormap jet;

% Writing as geotiff file

basename = 'geoinfo160288';
imagefile = [basename '.tif'];
geo=imread(imagefile);
geo=geo(1:1024,1:1024);

worldfile = getworldfilename(imagefile);
R = worldfileread(worldfile, 'geographic', size(geo));

filename1 = ['classymap' '.tif'];
geotiffwrite(filename1, newfet2, R)
filename2 = ['classymap2' '.tif'];
geotiffwrite(filename2, newfet2, R)
table2=[table(:,1) clasify2];

% Calculating misclassification cost and others.
%Data for confusion chart (Prior data and predicted data)

swaps=string(swap);
B = replace(swaps,'4','Flood');
B = replace(B,'1','Vegetation');
B = replace(B,'5','Flooded Vegetation');
B = replace(B,'3','Partially Submerged');
B = replace(B,'2','Dipole Scatterers');
B = replace(B,'0','Built-ups');

news=string(new1);
A= replace(news,'4','Flood');
A = replace(A,'1','Vegetation');
A = replace(A,'5','Flooded Vegetation');
A = replace(A,'3','Partially Submerged');
A = replace(A,'2','Dipole Scatterers');

figure(2);
CM2=confusionchart(new1,swap,'RowSummary','row-normalized','ColumnSummary','column-normalized');
cort=find(swap==new1);
accuracy=(length(cort)/length(swap))*100;
cp = classperf(one,two);




