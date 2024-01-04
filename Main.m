%% Polarimetric-Naive Bayes Flood mapping approach 
% DATE OF CREATION OF DOCUMENT: 16/09/2021 
%  AUTHOR: SAMVEDYA SURAMPUDI @Microwave lab, VIT University %%
%%
tic
clc
clear all
%_________________________SECTION-I_______________________________________
% (Reading data and initializing sizes)  
[lulc, flood, pol]=read_input();
tic
h=waitbar(0.1,'Please wait while model is running.................');
pause(1)
delete(h)

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
h=waitbar(0.5,'Please wait while model is running.................');
pause(0.5)
delete(h)
% Mergeing class labels in polarimetric dataset based on LULC
h=waitbar(0.7,'Please wait while model is running.................');
pause(0.5)
delete(h)

C={'6','7','8','9','10','11','12','13','14'};
P='Select Number of classes';
selection = listdlg('ListString',C, 'SelectionMode','single', 'PromptString',P);
No_cls=str2num(cell2mat(C(selection)));

[pol_new,lab_new]=merge_cls(pol,16,No_cls);
pol1=pol_new;

% \\\\ Buildings, Vegetation, Roads classes are unchanged ?? \\\\
% Fix class labels for buildings, vegetation and roads?

% pol1(find(bul==1))=lab_new(end)+1;
% pol1(find(veg==1))=lab_new(end)+2;
% pol1(find(road==1))=lab_new(end)+3;
% pol1(find(ot==1))=lab_new(end)+4; 

% figure(1)
% imshow(pol1,[]); colormap (rand(16,3)); impixelinfo; 
% Labelling the data 
table(:,1)=flood(:);
table(:,2)=pol1(:);
F_vec=flood(:); 
% Flood vector
%[fin_map,scores,c_lab]=GMM(table,F_vec ,nclas,flood,pol)
% nclass should be same as in merge_cls. Refer GMM function for more information
[fin_map,scores,c_lab,c_lab_new]=GMM(table,F_vec,No_cls,flood,pol1);
cmap=rand(16,3);
imwrite(fin_map,cmap,'classified.bmp')

%%
% Accuracy assessment 

figure(2);
CM=confusionchart(double(table(:,2)),fin_map(:),'RowSummary','row-normalized','ColumnSummary','column-normalized');
CM=confusionchart(c_lab,c_lab_new,'RowSummary','row-normalized','ColumnSummary','column-normalized');

accuracy = sum(table(:,2) == fin_map(:),'all')/numel(fin_map(:))*100;
time=toc;
% msgbox(sprintf("Accuracy= %d",accuracy),'METRICS')
% Receiver Operating Characteristics
% While calculating AUC- labels(nclas)is <= nclas value in GMM and
% merge_cls
% [X,Y,T,AUC] = perfcurve(c_lab_new(1:1000),scores(1:1000),labels(1));
% plot(X,Y); xlabel('False positive rate'); ylabel('True positive rate')
% hold on;
% [X,Y,T,AUC] = perfcurve(c_lab_new(1:1000),scores(1:1000),labels(2));
% plot(X,Y); xlabel('False positive rate'); ylabel('True positive rate')
% hold on;
% [X,Y,T,AUC] = perfcurve(c_lab_new(1:1000),scores(1:1000),labels(3));
% plot(X,Y); xlabel('False positive rate'); ylabel('True positive rate')
% hold on;
% [X,Y,T,AUC] = perfcurve(c_lab_new(1:1000),scores(1:1000),labels(4));
% plot(X,Y); xlabel('False positive rate'); ylabel('True positive rate')
% hold on;
% [X,Y,T,AUC] = perfcurve(c_lab_new(1:1000),scores(1:1000),labels(5));
% plot(X,Y); xlabel('False positive rate'); ylabel('True positive rate')
% hold on;
% [X,Y,T,AUC] = perfcurve(c_lab_new(1:1000),scores(1:1000),labels(6));
% plot(X,Y); xlabel('False positive rate'); ylabel('True positive rate')
% hold on;
% plot(X,Y); xlabel('False positive rate'); ylabel('True positive rate')
% hold on;
% [X,Y,T,AUC] = perfcurve(c_lab_new(1:1000),scores(1:1000),labels(10));
% plot(X,Y); xlabel('False positive rate'); ylabel('True positive rate')
% hold on;
% [X,Y,T,AUC] = perfcurve(c_lab(1:1000),scores(1:1000),labels(11));
% plot(X,Y); xlabel('False positive rate'); ylabel('True positive rate')


% Test here - change in GMM
% Test all the models with different n_class
% the zero class is coming because of unclassified pixels. 
% Read the naive bayes docmumentation again and adjust >nmean
toc








