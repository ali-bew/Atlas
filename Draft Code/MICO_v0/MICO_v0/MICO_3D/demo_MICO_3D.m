% This Matlab file demomstrates the method for simultaneous segmentation and bias field correction 
% in Chunming Li et al's paper:
%    "Multiplicative intrinsic component optimization (MICO) for MRI bias field estimation and tissue segmentation",
%     Magnetic Resonance Imaging, vol. 32 (7), pp. 913-923, 2014
% Author: Chunming Li, all rights reserved
% E-mail: li_chunming@hotmail.com
% URL:  http://imagecomputing.org/~cmli/

% Note: The 3D MICO algorithm is used to segment a synthetic 3D MR image in
% this demo. The code only shows the original image and segmentation result in one 2D slice, 
% although it produces 3D segmentation result.

% The 3D MICO algorithm perfoprms 3D segmentation and bias field
% correction, and the segmented image and bias field corrected image are
% saved as two files with file name 

clear all;
close all;

iterNum_outer=15;  % outer iteration
iterCM=2;  % inner interation for C and M
iter_b=1;  % inner iteration for bias
q = 1.5;   % fuzzifier
th_bg = 5;  %% threshold for removing background
N_region = 3; %% number of tissue types, e.g. WM, GM, CSF
tissueLabel=[1, 2, 3];
slice = 100;
Img00 = double(niftiread('C:\Users\developer\Desktop\bew\Courses Girona\MISA\lab\01\lab1handout\l1_preprocessing\braindata\braindata\t1_icbm_normal_1mm_pn0_rf0.nii'));
Img020 = double(niftiread('C:\Users\developer\Desktop\bew\Courses Girona\MISA\lab\01\lab1handout\l1_preprocessing\braindata\braindata\t1_icbm_normal_1mm_pn0_rf20.nii'));
Img040 = double(niftiread('C:\Users\developer\Desktop\bew\Courses Girona\MISA\lab\01\lab1handout\l1_preprocessing\braindata\braindata\t1_icbm_normal_1mm_pn0_rf40.nii'));
Img10 = double(niftiread('C:\Users\developer\Desktop\bew\Courses Girona\MISA\lab\01\lab1handout\l1_preprocessing\braindata\braindata\t1_icbm_normal_1mm_pn1_rf0.nii'));
Img50 = double(niftiread('C:\Users\developer\Desktop\bew\Courses Girona\MISA\lab\01\lab1handout\l1_preprocessing\braindata\braindata\t1_icbm_normal_1mm_pn5_rf0.nii'));
Img520 = double(niftiread('C:\Users\developer\Desktop\bew\Courses Girona\MISA\lab\01\lab1handout\l1_preprocessing\braindata\braindata\t1_icbm_normal_1mm_pn5_rf20.nii'));

% str_vector{1} = 't1_icbm_normal_1mm_pn0_rf20.mnc.gz.nii';   % input a sequence of image file names
str_vector{1} = 'C:\Users\developer\Desktop\bew\Courses Girona\MISA\lab\01\lab1handout\l1_preprocessing\braindata\braindata\t1_icbm_normal_1mm_pn0_rf20.nii';   % input a sequence of image file names
% str_vector{2} = 'brainweb_byte_B3N1.nii';


MICO_3Dseq(str_vector, N_region, q, th_bg, iterNum_outer, iter_b, iterCM, tissueLabel);
