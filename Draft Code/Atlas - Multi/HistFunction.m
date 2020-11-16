function [outputImg] = HistFunction(inputImg)
%UNTITLED3 Summary of this function goes here
%   Detailed explanation goes here
currentFolder = 'C:\Users\developer\Desktop\bew\Courses Girona\Project ISA - MIRA';
i = 7; % index of referene image in training data used for histmatch
if i < 10
    ppi = '0';% this is for path reading
else
    ppi = '';
end
fixedImagePath = strcat(currentFolder , '\Data\Training_Set Orig\IBSR_',ppi,num2str(i),'\IBSR_',ppi,num2str(i),'.nii');
fixedImage = niftireadB(fixedImagePath);
fixedImage(fixedImage<0) = 0;


inputImg(inputImg<0) = 0;
movingImage1 = inputImg;
                    
%apply hist matching excluding the mask
movingImage1(movingImage1>0) = imhistmatchn(uint8(inputImg(inputImg>0)),uint8(fixedImage(fixedImage>0)),256);

outputImg = movingImage1;
end

