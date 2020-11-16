function testDiffusion ()
clc;close all;clear all;
num_iter = 20;
delta_t = 0.1;
kappa = 1000;
option = 2;
currentFolder = pwd;
for it =1:1
slice = 100;
% Img00 = double(niftiread('C:\Users\developer\Desktop\bew\Courses Girona\MISA\lab\01\lab1handout\l1_preprocessing\braindata\braindata\t1_icbm_normal_1mm_pn0_rf0.nii'));
% Img020 = double(niftiread('C:\Users\developer\Desktop\bew\Courses Girona\MISA\lab\01\lab1handout\l1_preprocessing\braindata\braindata\t1_icbm_normal_1mm_pn0_rf20.nii'));
% Img040 = double(niftiread('C:\Users\developer\Desktop\bew\Courses Girona\MISA\lab\01\lab1handout\l1_preprocessing\braindata\braindata\t1_icbm_normal_1mm_pn0_rf40.nii'));
Img10 = double(niftiread('C:\Users\developer\Desktop\bew\Courses Girona\Project ISA - MIRA\DataSet\Training_Set\IBSR_01\IBSR_01.nii'));
% Img50 = double(niftiread('C:\Users\developer\Desktop\bew\Courses Girona\MISA\lab\01\lab1handout\l1_preprocessing\braindata\braindata\t1_icbm_normal_1mm_pn5_rf0.nii'));
% Img520 = double(niftiread('C:\Users\developer\Desktop\bew\Courses Girona\MISA\lab\01\lab1handout\l1_preprocessing\braindata\braindata\t1_icbm_normal_1mm_pn5_rf20.nii'));

% imshow(Img(:,:,120),[]);

% Img00 =uint8( Img00 ./(max(max(max(Img00()))))*255 );
% Img020 =uint8( Img020 ./(max(max(max(Img020()))))*255 );
% Img040 =uint8( Img040 ./(max(max(max(Img040()))))*255 );
% Img10 =uint8( Img10 ./(max(max(max(Img10()))))*255 );
% Img50 =uint8( Img50 ./(max(max(max(Img50()))))*255 );
% Img520 =uint8( Img520 ./(max(max(max(Img520()))))*255 );


%Img=imread('mprage171.tif');
Img = Img10;
Img = double(Img(:,:,:));


% im1 = rgb2gray(imread('pa6-16_t2.png'));
%im1 = (dicomread('slice_3D.dcm'));
im1=Img;
%blurring
H = fspecial('disk',3);
blurred = imfilter(im1,H,'replicate');

ad = anisodiff(im1,num_iter,kappa,delta_t,option);
% figure, subplot 131, imshow(im1,[]), subplot 132, imshow(ad,[]), subplot 133, imshow(blurred,[])

% figure;
% Imgref = Img00;
% Imgref = Imgref(:,:,slice);
% distref = dist(ad,Imgref);
% [distrefMean,] = stat(distref);
% % distoriginal = dist(Img,Imgref(:,:,slice),ROI);
% % [distoriginalMean,] = stat(distoriginal,ROI);
% %  distoriginal = abs(double(double(Imgref(:,:,slice)).*ROI) - double(Img.*ROI));
% snrbefore=double(((abs(double(Imgref)-double(Img)))));
% snrafter=double((abs((double(Imgref)-double(ad)))));
% [,snrbeforemean] = stat(snrbefore);
% [,snraftermean] = stat(snrafter);
% % devafter = double(M(:,:,3)).*double(img_bc).*ROI;
% % [m,d] = stat(devafter,ROI)
% % devbefore = double(M(:,:,3)).*double(Img).*ROI;
% % [m1,d1] = stat(devbefore,ROI)
% % devref = double(M(:,:,3)).*double(Imgref(:,:,slice)).*ROI;
% % [m2,d2] = stat(devref,ROI)
% edge1 = edge(Img,'log',0.1);
% edge2 = edge(ad,'log',0.1);
% [edge1DistMean,] = stat(dist(edge1,edge2));
% 
% % [ssimval1,ssimmap1] = ssim(Img,Imgref);
% % [ssimval2,ssimmap2] = ssim(de,Imgref);
% subplot(3,2,1),imshow(im1,[]),title('Original Image');
% subplot(3,2,2),imshow(ad,[]),title('Corrected Image');
% 
% subplot(3,2,3),imshow(uint8(distref),[]),title(strcat('mean distance from ref:' , num2str(distrefMean)));
% %subplot(3,2,9),imshow(uint8(distoriginal),[]),title(strcat('mean distance original:' , num2str(mean(mean(distoriginal))*1.0)));
% subplot(3,2,5),imshow(snrbefore),title(strcat('Noise before processing' ,num2str(snrbeforemean)));
% subplot(3,2,6),imshow(snrafter),title(strcat('Noise after processing' ,num2str(snraftermean)));
% % subplot(3,2,3),imshow(devbefore),title(strcat('Deviation before :',num2str(d1))) ;
% % subplot(3,2,4),imshow(devafter),title(strcat('Deviation after :',num2str(d))) ;
% % subplot(3,2,6),imshow(devref),title(strcat('original :',num2str(d2))) ;
% subplot(3,2,4),imshow(edge1),title(strcat('edge based Comparison :',num2str(edge1DistMean))) ;
% % subplot(3,2,8),imshow(edge2),title(strcat('ed2 :','')) ;
% 
% X(it)=kappa ;
% Y(it) = snraftermean;
% Z(it) = edge1DistMean*100;
% kappa=kappa +0.9;
end
% figure
% p = plot(X,Y,X,Z);
% p(1).LineWidth = 0.2;
% p(2).Marker = '*';
% xlabel('Kappa');
% legend('Distance ( less better )','Edge Distance ( max 1.7 )')
% df=zeros(size(snrafter,1)-2,size(snrafter,2)-2);
% for i=5:size(snrafter,1)-7
%    for j=5:size(snrafter,2)-7
%         m = (snrafter(i+2,j) + snrafter(i,j+2) + snrafter(i,j-2))/1;
%         if abs(m-snrafter(i,j))<5
%             df(i,j) = 1;
%         end
%    
%    end 
% end
% 
% df1=zeros(size(snrbefore,1)-2,size(snrbefore,2)-2);
% for i=5:size(snrbefore,1)-7
%    for j=5:size(snrbefore,2)-7
%         m = (snrbefore(i+2,j) + snrbefore(i,j+2) + snrbefore(i,j-2))/1;
%         if abs(m-snrbefore(i,j))<5
%             df1(i,j) = 1;
%         end
%    
%    end 
% end
% figure;
% imshow(df);
% figure;
% imshow(df1);
