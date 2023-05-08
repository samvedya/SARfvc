function [pol_new, lab_new]= merge_cls(pol, nclas, nfin)

% MERGE_CLS REDUCES/MERGES CLASSES IN POLARIMETRIC DECOMPOSED DATASET (REFERENCE DATASET)  
% TO  REQUESTED NUMBER OF FINAL CLASSESS.

% pol- MXN matrix with n unique classes 
% nclas- No. of classess in pol dataset
% nclas ideal is 6 to input to GMM but the function seperately works for
% any class below 16
% nfin - No. of final classes  
% nclas should always be less than number of classes in reference dataset

% (C) Samvedya Surampudi@ VIT University 

if nargin==3
    
    pol=pol;
    nc=nclas; 
    nf=nfin; 
    
    
    count=grouptransform(pol(:),pol(:),@numel); % Counts for each class
    tab=unique(table(count,pol(:))); tab=table2array(tab); % table with counts respective to each class

    for i=1:nc
        layer1{i}=ones(size(pol,1),size(pol,2));
        layer1{i}(find(pol~=tab(end-i+1,2:2)))=0; 
%         figure(i)
%         imshow(layer1{i})
    end
    
   
 pol_new=zeros(size(pol,1),size(pol,2));
 i=1; 
  while i<=nfin
    pol_new = pol_new+layer1{i}+layer1{i+1}; % adding nfin times
    pol_new(pol_new==1)=i;
    i=i+1;
  end
lab=unique(pol_new);

% Bring all the class labels between 1 and cfin
i=1;
while i<length(lab)+1
    pol_new(pol_new==lab(i)) =i;
    i=i+1;
end
     
lab_new=unique(pol_new);
figure(1)
imshow(pol_new,[]);colormap (rand(16,3)); impixelinfo;   
 


end