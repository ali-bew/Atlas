clear all;close all;
N = 40 ; % number of files in training data
currentFolder = 'C:\Users\developer\Desktop\bew\Courses Girona\Project ISA - MIRA';
classes=3;
deleteAfterDone = false;
imageResultName = 'result.1.nii';
labelResultName = 'result.nii';
movingImagePath = strcat(currentFolder ,'\Data\results\probAtlasImage.nii');
movingMaskPath = strcat(currentFolder ,'\Data\results\probAtlasMask.nii');
labelPath = strcat(currentFolder ,'\Data\results\probAtlasLabel.nii');
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
        
            
outputFolder = strcat(strcat(currentFolder ,'\Data\results3\label'),num2str(j));              
fixedImagePath = strcat(strcat(currentFolder , '\Data\results1\output',num2str(j)),'\',imageResultName);
fixedMaskPath = strcat(strcat(currentFolder , '\Data\results1\output',num2str(j)),'\',imageResultName);
if isfile(fixedImagePath) 
       
label1 = strcat(currentFolder , '\Data\results1\label',num2str(j),'-1\',labelResultName);
label2 = strcat(currentFolder , '\Data\results1\label',num2str(j),'-2\',labelResultName);
label3 = strcat(currentFolder , '\Data\results1\label',num2str(j),'-3\',labelResultName);


mkdir(outputFolder);

Ip1 = niftireadB(label1);
Ip2 = niftireadB(label2);
Ip3 = niftireadB(label3);

Itm = niftireadB(fixedImagePath);

Itm1 = intlut(uint16(Itm),uint16(Table(:,2)*10000));
Itm1 = double(Itm1)/10000;

Itm2 = intlut(uint16(Itm),uint16(Table(:,3)*10000));
Itm2 = double(Itm2)/10000;

Itm3 = intlut(uint16(Itm),uint16(Table(:,4)*10000));
Itm3 = double(Itm3)/10000;
clear I;
I(:,:,:,1) = double(Ip1)/15000.*double(Itm1); %this step is needed for registration
I(:,:,:,2) = double(Ip2)/15000.*double(Itm2);
I(:,:,:,3) = double(Ip3)/15000.*double(Itm3);

masking = I(:,:,:,1) + I(:,:,:,2) + I(:,:,:,3);
masking = masking >0; %when all labels are zero
[f,ind ] = max(I,[],4);
% ind = flip(ind,2);
answ = ind.*double(masking);
% answ = flip(answ,2);
niftiwriteB(answ,info3,strcat(outputFolder,'\',labelResultName));
niftiwriteB(I(:,:,:,1),info3,strcat(outputFolder,'\prob1',labelResultName));
niftiwriteB(I(:,:,:,2),info3,strcat(outputFolder,'\prob2',labelResultName));
niftiwriteB(I(:,:,:,3),info3,strcat(outputFolder,'\prob3',labelResultName));
end
end
    