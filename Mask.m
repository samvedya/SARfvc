%% Extended probabilistic flood mapping
%  Creating masks from LULC data%%
%  DATE OF CREATION OF DOCUMENT: 16/09/2021 
%  AUTHOR: SAMVEDYA SURAMPUDI @Microwave lab, VIT University %%
%%


% creating mask and cropping

lulc=imread('LULC2.tif');% Land Use Land Cover
a1=a(:,:,1); % Water
a2=a(:,:,2); % vegetation
a3=a(:,:,3); % Buildings/Urban
figure(1)

% Extraction of water bodies
% Create ROIs for water bodies
f=area22_cal; 
figure(2)
imshow(area11_cal,[135,170])
hold on;
[vegetation,width1]= imcontour(imresize(a2,1.18),2);
width.LineWidth=2;
roi1=drawfreehand;  roi2=drawfreehand;roi3=drawfreehand;roi4=drawfreehand;roi5=drawfreehand;roi6=drawfreehand;
roi7=drawfreehand;roi8=drawfreehand;roi9=drawfreehand;roi10=drawfreehand;roi11=drawfreehand;roi12=drawfreehand;
roi13=drawfreehand;roi14=drawfreehand;roi15=drawfreehand;roi16=drawfreehand;
impixelinfo;

x1=round(roi1.Position(:,1));
y1=round(roi1.Position(:,2));
bw1 = poly2mask(x1,y1,size(lulc,1),size(lulc,2));

x2=round(roi2.Position(:,1));
y2=round(roi2.Position(:,2));
bw2 = poly2mask(x2,y2,size(lulc,1),size(lulc,2));

x3=round(roi3.Position(:,1));
y3=round(roi3.Position(:,2));
bw3 = poly2mask(x3,y3,size(lulc,1),size(lulc,2);

x4=round(roi4.Position(:,1));
y4=round(roi4.Position(:,2));
bw4 = poly2mask(x4,y4,size(lulc,1),size(lulc,2));

x5=round(roi5.Position(:,1));
y5=round(roi5.Position(:,2));
bw5 = poly2mask(x5,y5,size(lulc,1),size(lulc,2));

x6=round(roi6.Position(:,1));
y6=round(roi6.Position(:,2));
bw6 = poly2mask(x6,y6,size(lulc,1),size(lulc,2));

x7=round(roi7.Position(:,1));
y7=round(roi7.Position(:,2));
bw7 = poly2mask(x7,y7,size(lulc,1),size(lulc,2));

x8=round(roi8.Position(:,1));
y8=round(roi8.Position(:,2));
bw8 = poly2mask(x8,y8,size(lulc,1),size(lulc,2));

x9=round(roi9.Position(:,1));
y9=round(roi9.Position(:,2));
bw9 = poly2mask(x9,y9,size(lulc,1),size(lulc,2));

x10=round(roi10.Position(:,1));
y10=round(roi10.Position(:,2));
bw10 = poly2mask(x10,y10,size(lulc,1),size(lulc,2));

x11=round(roi11.Position(:,1));
y11=round(roi11.Position(:,2));
bw11 = poly2mask(x11,y11,size(lulc,1),size(lulc,2));

x12=round(roi12.Position(:,1));
y12=round(roi12.Position(:,2));
bw12 = poly2mask(x12,y12,size(lulc,1),size(lulc,2));

x13=round(roi13.Position(:,1));
y13=round(roi13.Position(:,2));
bw13 = poly2mask(x13,y13,size(lulc,1),size(lulc,2));

x14=round(roi14.Position(:,1));
y14=round(roi14.Position(:,2));
bw14 = poly2mask(x14,y14,size(lulc,1),size(lulc,2));

x15=round(roi15.Position(:,1));
y15=round(roi15.Position(:,2));
bw15 = poly2mask(x15,y15,size(lulc,1),size(lulc,2));

x16=round(roi16.Position(:,1));
y16=round(roi16.Position(:,2));
bw16 = poly2mask(x16,y16,size(lulc,1),size(lulc,2));

BWM=bw1+bw2+bw3+bw4+bw5+bw6+bw7+bw8+bw9+bw10+bw11+bw12+bw13+bw14+bw15+bw16;
imshow(BWM,[])
test=area11_filt.*BWM;
test_vec=test(:);
Indt1=find(test_vec);
m1=sum(test_vec)/(length(Indt1));


%%
% Vegetation
figure(2)
imshow(area11_filt,[135,170])
hold on;
[Vegetation,width2]= imcontour(imresize(a3,1.18),2);
width2.LineWidth=2;

roi11_1=drawfreehand;roi12_1=drawfreehand;roi13_1=drawfreehand;roi14_1=drawfreehand;roi15_1=drawfreehand;roi16=drawfreehand;

x11_1=round(roi11_1.Position(:,1));
y11_1=round(roi11_1.Position(:,2));
bw11_1 = poly2mask(x11_1,y11_1,size(lulc,1),size(lulc,2);

x12_1=round(roi12_1.Position(:,1));
y12_1=round(roi12_1.Position(:,2));
bw12_1 = poly2mask(x12_1,y12_1,size(lulc,1),size(lulc,2);

x13_1=round(roi13_1.Position(:,1));
y13_1=round(roi13_1.Position(:,2));
bw13_1 = poly2mask(x13_1,y13_1,size(lulc,1),size(lulc,2));

x14_1=round(roi14_1.Position(:,1));
y14_1=round(roi14_1.Position(:,2));
bw14_1 = poly2mask(x14_1,y14_1,size(lulc,1),size(lulc,2));

x15_1=round(roi15_1.Position(:,1));
y15_1=round(roi15_1.Position(:,2));
bw15_1 = poly2mask(x15_1,y15_1,size(lulc,1),size(lulc,2));

x16_1=round(roi16_1.Position(:,1));
y16_1=round(roi16_1.Position(:,2));
bw16_1 = poly2mask(x16_1,y16_1,size(lulc,1),size(lulc,2));


BVM1= bw11_1+bw12_1+bw14_1+bw15_1;+bw16_1;
test3=area11_filt.*BVM1;
test3_vec=test3(:);
m3=sum(test3_vec)/(length(Indt3));
Indt3=find(test3_vec);


%%
% Buildings
figure(3)
imshow(area11_cal,[135,170])
hold on;
[Urban,width1]= imcontour(imresize(a3,1.18),2);
width1.LineWidth=2;
roi11=drawfreehand; roi22=drawfreehand;roi33=drawfreehand;roi44=drawfreehand;roi55=drawfreehand;roi66=drawfreehand;
roi77=drawfreehand;roi88=drawfreehand;roi99=drawfreehand;roi10_1=drawfreehand;


x11=round(roi11.Position(:,1));
y11=round(roi11.Position(:,2));
bw11 = poly2mask(x11,y11,size(lulc,1),size(lulc,2));
imshow(bw11,[])


x22=round(roi22.Position(:,1));
y22=round(roi22.Position(:,2));
bw22 = poly2mask(x22,y22,size(lulc,1),size(lulc,2));


x33=round(roi33.Position(:,1));
y33=round(roi33.Position(:,2));
bw33 = poly2mask(x33,y33,size(lulc,1),size(lulc,2));

x44=round(roi44.Position(:,1));
y44=round(roi44.Position(:,2));
bw44 = poly2mask(x44,y44,size(lulc,1),size(lulc,2));

x55=round(roi55.Position(:,1));
y55=round(roi55.Position(:,2));
bw55 = poly2mask(x55,y55,size(lulc,1),size(lulc,2));

x66=round(roi66.Position(:,1));
y66=round(roi66.Position(:,2));
bw66 = poly2mask(x66,y66,size(lulc,1),size(lulc,2));

x77=round(roi77.Position(:,1));
y77=round(roi77.Position(:,2));
bw77 = poly2mask(x77,y77,size(lulc,1),size(lulc,2));

x88=round(roi88.Position(:,1));
y88=round(roi88.Position(:,2));
bw88 = poly2mask(x88,y88,size(lulc,1),size(lulc,2));

x99=round(roi99.Position(:,1));
y99=round(roi99.Position(:,2));
bw99 = poly2mask(x99,y99,size(lulc,1),size(lulc,2));

x10_1=round(roi10_1.Position(:,1));
y10_1=round(roi10_1.Position(:,2));
bw10_1 = poly2mask(x10_1,y10_1,size(lulc,1),size(lulc,2));

BBM=bw11+bw22+bw33+bw44+bw55+bw66+bw77+bw88+bw99+bw10_1; %+bw11+bw12+bw13+bw14+bw15+bw16;
test2=area11_filt.*BBM;
test2_vec=test2(:);
Indt2=find(test2_vec);
m2=sum(test2_vec)/(length(Indt2));

