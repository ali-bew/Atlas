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
%     mkm = niftireadB(labelPath);
    answ = intlut(uint16(img),uint16(Table(:,5)));
%     answ = flip(answ.*uint16(mmmm),2);

% labeltruth = niftireadB('C:\Users\developer\Desktop\bew\Courses Girona\MIRA\Labs\02\training-set\training-labels\1013_3C.nii');
% 
% % masking = flip(masking,2);
% for i=0:3
%     for j=0:3
%         for k=0:3
%             for l=0:3
%         answ = intlut(uint16(img),uint16(Table(:,5)));
%         masking = niftireadB(fixedMaskPath);
% disp(strcat(num2str(i),'-',num2str(j),'-',num2str(k),'-',num2str(l)));
% if i>0
%         answ = flip(answ,i);
% end
% if j>0
%         answ = flip(answ,j);
% end
% if k>0
%         answ = flip(answ,k);
% end
% if l>0
%         masking = flip(masking,l);
% end
% %         masking = flip(masking,j);
% 
%         
%         niftiwrite(answ.*uint16(masking),strcat(outputFolder,'\result.nii'));
%         
%         labeltissuemodel = niftireadB('C:\Users\developer\Desktop\bew\Courses Girona\MIRA\Labs\02\results2\label13\result.nii');
% 
%         dice(double(labeltruth),double(labeltissuemodel))
%     %     
%     %     answ = flip(answ.*uint16(masking),1);
%         end
%         end
%         end
% end

%     answ = flip(answ,2);
%     masking = flip(masking,2);
    
%     dice(double(labeltruth),double(labeltissuemodel))
%     
%     answ = flip(answ.*uint16(masking),1);
    niftiwriteB(masking,info3,strcat(outputFolder,'\result.nii'));
    
%     an = info.raw ;
% %     info.raw.bitpix = 32 ;
% %     info.raw.datatype = 512 ;
%     info.raw.srow_x = [-1 0 0 127.5] ;
%     info.raw.srow_y = [0 1 0 -127.5] ;
%     info.raw.srow_z = [0 0 1 -150.5] ;
%     info.raw.pixdim = [-1 1 1 1 1 1 1 1];
%     info.raw.sform_code = 2;
%     info.raw.intent_name='n+1';
%     info.raw.magic='';
%     %info.raw = an;
%     info.raw
%     class(img)
    niftiwriteB(answ.*uint16(masking),info3,strcat(outputFolder,'\result.nii'));
    
    end
    end
    
    
    
    
    
    
    
    
    
    
    
    