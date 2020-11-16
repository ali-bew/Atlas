function [outputArg1] = postRegister(inputArg1)
N = 40 ; % number of files in training data
currentFolder = pwd;
imageResultName = 'result.1.nii';
labelResultName = 'result.nii';

    for i = 12:12 %i is the fixed image, the loop is for testing all atlases choices
        
        if i < 10
            ppi = '0';% this is for path reading
        else
            ppi = '';
        end
        sourceLabelFolder = strcat(strcat(currentFolder ,'\results\label'),num2str(i)); 
        sourceLabel = strcat(sourceLabelFolder,'\',labelResultName);
        sourceL = niftireadB(sourceLabel);
        
        sourceImageFolder = strcat(strcat(currentFolder ,'\results\output'),num2str(i)); 
        sourceImage = strcat(sourceImageFolder,'\',imageResultName);
        sourceI = niftireadB(sourceImage);
        
        tur = 1;
        for j = 0:N
            
            if j < 10
                ppj = '0';% this is for path reading
            else
                ppj = '';
            end
            if i ~= j
                destLabelFolder = strcat(strcat(currentFolder ,'\results\label'),num2str(j)); 
                destLabel = strcat(destLabelFolder,'\',labelResultName);
                
                destImageFolder = strcat(strcat(currentFolder ,'\results\output'),num2str(j)); 
                destImage = strcat(destImageFolder,'\',imageResultName);
                
                if isfile(destLabel)
                    destL = niftireadB(destLabel);
                    destI = niftireadB(destImage);
                    
                    d(tur) = ssim(double(sourceI),double(destI));
                    tur = tur +1;
%                     return
%                     dice(double(sourceL(:,:,20:30)),double(destL(:,:,20:30)))
%                     
%                     return
                                      
                end
               
            end
            
        end
        d
        mean(d)
        std(d)
    end
end

