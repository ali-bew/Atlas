function [outputArg1] = propagateAtlas(inputArg1,Reregister)
N = 40 ; % number of files in training data
currentFolder = 'C:\Users\developer\Desktop\bew\Courses Girona\Project ISA - MIRA';
classes=3;
registerBefore = Reregister; % this is the parameter where we register one more time to the targt image
deleteAfterDone = false;
imageResultName = 'result.1.nii';
labelResultName = 'result.nii';
movingImagePath = strcat(currentFolder ,'\Data\results\probAtlasImage.nii');
movingMaskPath = strcat(currentFolder ,'\Data\results\probAtlasMask.nii');
labelPath = strcat(currentFolder ,'\Data\results\probAtlasLabel.nii');
labelPath1 = strcat(currentFolder ,'\Data\results\probAtlasLabel1_.nii');
labelPath2 = strcat(currentFolder ,'\Data\results\probAtlasLabel2_.nii');
labelPath3 = strcat(currentFolder ,'\Data\results\probAtlasLabel3_.nii');

    
    for j = inputArg1:inputArg1
            
        if j < 10
            ppj = '0';% this is for path reading
        else
            ppj = '';
        end
%   ppi=''; 
%     ppj=''; 
%   i=13;    
%     j=13;    
        
    outputFolder = strcat(strcat(currentFolder ,'\Data\results1\output'),num2str(j));              
    fixedImagePath = strcat(currentFolder , '\Data\Validation_Set\IBSR_',ppj,num2str(j),'\IBSR_',ppj,num2str(j),'.nii');
    fixedMaskPath = strcat(currentFolder , '\Data\Validation_Set\IBSR_',ppj,num2str(j),'\IBSR_',ppj,num2str(j),'_mask.nii');
   if isfile(fixedImagePath) 
       
       if (registerBefore )

           
        j
%         d=niftiread(movingImagePath);
%         l = uint16(d(:,:,:,1));
%         niftiwrite(l,'C:\Users\developer\Desktop\bew\Courses Girona\MIRA\Labs\02\results\probAtlasImage.nii');
%         return;
    mkdir(outputFolder);
    
    command = ['elastix -f "' fixedImagePath '" -m "' movingImagePath '" -out "' outputFolder '" -p parameters1-0000.txt -p parameters2-0000.txt' ' -fMask "' fixedMaskPath '"' ' -mMask "' movingMaskPath '"'];
    disp(command)
    [status,cmdout] = dos(command);

    cmdout

    labelFolder = strcat(strcat(currentFolder ,'\Data\results1\label'),num2str(j));
    labelFolder1 = strcat(strcat(currentFolder ,'\Data\results1\label'),num2str(j),'-1');
    labelFolder2 = strcat(strcat(currentFolder ,'\Data\results1\label'),num2str(j),'-2');
    labelFolder3 = strcat(strcat(currentFolder ,'\Data\results1\label'),num2str(j),'-3');
%     labelPath = 'C:\Users\developer\Desktop\bew\Courses Girona\MIRA\Labs\02\results\probAtlasLabel.nii';
    mkdir(labelFolder);
    mkdir(labelFolder1);
    mkdir(labelFolder2);
    mkdir(labelFolder3);
    transformPath0 = strcat(outputFolder,'\TransformParameters.0.txt');
    transformPath1 = strcat(outputFolder,'\TransformParameters.1.txt');
    %modify the transformation file
    command1 = ['ReplaceStringInFile "' transformPath0 '" "(FinalBSplineInterpolationOrder 3)" "(FinalBSplineInterpolationOrder 0)"' ];
    [status1,cmdout1] = dos(command1);
    cmdout1
    command11 = ['ReplaceStringInFile "' transformPath1 '" "(FinalBSplineInterpolationOrder 3)" "(FinalBSplineInterpolationOrder 0)"' ];
    [status11,cmdout11] = dos(command11);
    cmdout11

    command2 = ['transformix -in "' labelPath '" -out "' labelFolder '" -tp "' transformPath1 '"'];
    [,cmdout2] = dos(command2);
    cmdout2
    
    command3 = ['transformix -in "' labelPath1 '" -out "' labelFolder1 '" -tp "' transformPath1 '"'];
    [,cmdout3] = dos(command3);
    cmdout3
    
    command4 = ['transformix -in "' labelPath2 '" -out "' labelFolder2 '" -tp "' transformPath1 '"'];
    [,cmdout4] = dos(command4);
    cmdout4
    
    command5 = ['transformix -in "' labelPath3 '" -out "' labelFolder3 '" -tp "' transformPath1 '"'];
    [,cmdout5] = dos(command5);
    cmdout5

%             if deleteAfterDone
%                 listingO = dir(outputFolder);
%                 listingL = dir(labelFolder);
%                 for k =1:size(listingO)
%                     if not(contains(listingO(k).name,imageResultName))
%                         delete(strcat(listingO(k).folder,'\',listingO(k).name));
%                     end
%                 end
%                 for k =1:size(listingL)
%                     if not(contains(listingL(k).name,labelResultName))
%                         delete(strcat(listingL(k).folder,'\',listingL(k).name));
%                     end
%                 end
%             end
       else
           outputFolder = strcat(strcat(currentFolder ,'\Data\results1\output'),num2str(j));  
            labelFolder = strcat(strcat(currentFolder ,'\Data\results1\label'),num2str(j));
            labelFolder1 = strcat(strcat(currentFolder ,'\Data\results1\label'),num2str(j),'-1');
            labelFolder2 = strcat(strcat(currentFolder ,'\Data\results1\label'),num2str(j),'-2');
            labelFolder3 = strcat(strcat(currentFolder ,'\Data\results1\label'),num2str(j),'-3');
        %     labelPath = 'C:\Users\developer\Desktop\bew\Courses Girona\MIRA\Labs\02\results\probAtlasLabel.nii';
            mkdir(outputFolder);    
            mkdir(labelFolder);
            mkdir(labelFolder1);
            mkdir(labelFolder2);
            mkdir(labelFolder3);
            copyfile(movingImagePath, strcat(outputFolder,'\',imageResultName));
            copyfile(labelPath, strcat(labelFolder,'\',labelResultName));
            %
            % mask = niftireadB('C:\Users\developer\Desktop\bew\Courses Girona\Project ISA - MIRA\Data\Validation_Set Orig\IBSR_13\IBSR_13_mask.nii');
% resu = niftireadB('C:\Users\developer\Desktop\bew\Courses Girona\Project ISA - MIRA\Data\results3\label13\result.nii');
% 
%             fixedMaskPath = strcat(currentFolder , '\Data\Validation_Set Orig\IBSR_',ppj,num2str(j),'\IBSR_',ppj,num2str(j),'_mask.nii');
%             img = niftireadB('C:\Users\developer\Desktop\bew\Courses Girona\Project ISA - MIRA\Data\results3\label13\result.nii');
%             mask = niftireadB('C:\Users\developer\Desktop\bew\Courses Girona\Project ISA - MIRA\Data\Validation_Set Orig\IBSR_13\IBSR_13_seg.nii');
%             img(mask~=0 & img==0)=2;
%             niftiwriteB(img,strcat(labelFolder,'\',labelResultName),strcat(labelFolder,'\',labelResultName));
            %
            
   
            copyfile(labelPath1, strcat(labelFolder1,'\',labelResultName));
            copyfile(labelPath2, strcat(labelFolder2,'\',labelResultName));
            copyfile(labelPath3, strcat(labelFolder3,'\',labelResultName));
        
                
       end
        
       
    end
    end
end
