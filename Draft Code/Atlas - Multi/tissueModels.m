clear all; close all;
N = 40 ; % number of files in training data
currentFolder = 'C:\Users\developer\Desktop\bew\Courses Girona\Project ISA - MIRA';
classes=3;
deleteAfterDone = false;
imageResultName = 'result.1.nii';
labelResultName = 'result.nii';
movingImagePath = strcat(currentFolder ,'\Data\results\probAtlasImage.nii');
movingMaskPath = strcat(currentFolder ,'\Data\results\probAtlasMask.nii');
labelPath = strcat(currentFolder ,'\Data\results\probAtlasLabel.nii');

atlasPath = strcat(currentFolder ,'\Data\results\probAtlas.nii');
atlasLabelPath = strcat(currentFolder ,'\Data\results\probAtlasLabel.nii');
info3=strcat(currentFolder ,'\Data\Training_Set\IBSR_01\IBSR_01_seg.nii');

% ppi=''; 
% ppj=''; 
% i=13;    
% j=13;    
        Table = TissueModelsFunction(); 
    for j = 0:N
            
            if j < 10
            ppj = '0';% this is for path reading
        else
            ppj = '';
        end
    outputFolder = strcat(strcat(currentFolder ,'\Data\results2\label'),num2str(j));              
    fixedImagePath = strcat(currentFolder , '\Data\Validation_Set\IBSR_',ppj,num2str(j),'\IBSR_',ppj,num2str(j),'.nii');
    fixedMaskPath = strcat(currentFolder , '\Data\Validation_Set\IBSR_',ppj,num2str(j),'\IBSR_',ppj,num2str(j),'_seg.nii');
   if isfile(fixedImagePath) 
        j
    mkdir(outputFolder);

    

    
%     Table(1:1,5)=zeros;%to be discussed , this is the mask
     masking = niftireadB(fixedMaskPath);
     masking = masking ==0;
     masking = 1 - masking;
    img = niftireadB(fixedImagePath);
%    
%
% img = HistFunction(img(:,:,:,1));
%
%

    answ = intlut(uint16(img),uint16(Table(:,5)));

    niftiwriteB(answ.*uint16(masking),info3,strcat(outputFolder,'\result.nii'));
    
    end
    end
    
    
    
    
    
    
    
    
    
    
    
    