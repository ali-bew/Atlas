function [outputArg1] = register(inputArg1)
N = 20 ; % number of files in training data
currentFolder = 'C:\Users\developer\Desktop\bew\Courses Girona\Project ISA - MIRA';
deleteAfterDone = false;
imageResultName = 'result.1.nii';
labelResultName = 'result.nii';

% the executable "ReplaceStringInFile.exe" was created using vb.net and it is a
% a command line tool we created it to modify content of text file .

% to run this code place the dataset in the same directory of code.

    for i = 7:7 %i is the fixed image, the loop is for testing all atlases choices
        
        if i < 10
            ppi = '0';% this is for path reading
        else
            ppi = '';
        end
        
        for j = 0:N
            
            if j < 10
            ppj = '0';% this is for path reading
        else
            ppj = '';
        end
            if i ~= j
                outputFolder = strcat(strcat(currentFolder ,'\Data\results\output'),num2str(j));              
                fixedImagePath = strcat(currentFolder , '\Data\Training_Set\IBSR_',ppi,num2str(i),'\IBSR_',ppi,num2str(i),'.nii');
                fixedMaskPath = strcat(currentFolder , '\Data\Training_Set\IBSR_',ppi,num2str(i),'\IBSR_',ppi,num2str(i),'_mask.nii');
                movingImagePath = strcat(currentFolder , '\Data\Training_Set\IBSR_',ppj,num2str(j),'\IBSR_',ppj,num2str(j),'.nii');
                movingMaskPath = strcat(currentFolder , '\Data\Training_Set\IBSR_',ppj,num2str(j),'\IBSR_',ppj,num2str(j),'_mask.nii');
                
                if isfile(fixedImagePath) && isfile(movingImagePath)
                    mkdir(outputFolder);
                    command = ['elastix -f "' fixedImagePath '" -m "' movingImagePath '" -out "' outputFolder '" -p parameters1-0000.txt -p parameters2-0000.txt' ' -fMask "' fixedMaskPath '"' ' -mMask "' movingMaskPath '"'];
                    disp(command)
                    [status,cmdout] = dos(command);

                    cmdout

                    labelFolder = strcat(strcat(currentFolder ,'\Data\results\label'),num2str(j));
                    labelPath = strcat(currentFolder , '\Data\Training_Set\IBSR_',ppj,num2str(j),'\IBSR_',ppj,num2str(j),'_seg.nii');
                    mkdir(labelFolder);
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
                    
                    if deleteAfterDone
                        listingO = dir(outputFolder);
                        listingL = dir(labelFolder);
                        for k =1:size(listingO)
                            if not(contains(listingO(k).name,imageResultName))
                                delete(strcat(listingO(k).folder,'\',listingO(k).name));
                            end
                        end
                        for k =1:size(listingL)
                            if not(contains(listingL(k).name,labelResultName))
                                delete(strcat(listingL(k).folder,'\',listingL(k).name));
                            end
                        end
                    end
                    
                  
                end
            else
                outputFolder = strcat(strcat(currentFolder ,'\Data\results\output'),num2str(j));
                fixedImagePath = strcat(currentFolder , '\Data\Training_Set\IBSR_',ppi,num2str(i),'\IBSR_',ppi,num2str(i),'.nii');
                mkdir(outputFolder);
                labelFolder = strcat(strcat(currentFolder ,'\Data\results\label'),num2str(i));
                labelPath = strcat(currentFolder , '\Data\Training_Set\IBSR_',ppi,num2str(i),'\IBSR_',ppi,num2str(i),'_seg.nii');
                mkdir(labelFolder);
                destinationImage = strcat(outputFolder,'\',imageResultName);
                destinationLabel = strcat(labelFolder,'\',labelResultName);
                copyfile(fixedImagePath, destinationImage)
                copyfile(labelPath, destinationLabel)
            
            end
        end
    end
end

