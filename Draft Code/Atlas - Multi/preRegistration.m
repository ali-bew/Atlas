function [outputArg1] = preRegistration(inputArg1,method,Threshold)

function C = sortBlikeA(B,A)
sort(B)
   [~,Bsort]=sort(B,'descend'); %Get the order of B
    C=A(Bsort);
end


% close all;clear all;
N = 40 ; % maximum index of files in training data

% Thresh = (2.5/2); %increase the value for less choices
Thresh = Threshold;
currentFolder = 'C:\Users\developer\Desktop\bew\Courses Girona\Project ISA - MIRA';
starting = 0;
if nargin > 0
    starting = inputArg1;
    N = inputArg1;
end

turr = 1;
    for i = starting:N %i is the fixed image 
        if i < 10
            ppi = '0';% this is for path reading
        else
            ppi = '';
        end
        tur = 1;
        
        fixedImagePath = strcat(currentFolder , '\Data\Validation_Set\IBSR_',ppi,num2str(i),'\IBSR_',ppi,num2str(i),'.nii');
   i
        if isfile(fixedImagePath)
           
            fixedImage = double(niftireadB(fixedImagePath));
            fixedImage(fixedImage<0) = 0;
    
            for j = 0:40   
             
                if j < 10
                    ppj = '0';% this is for path reading
                else
                    ppj = '';
                end
                movingImagePath = strcat(currentFolder , '\Data\Training_Set\IBSR_',ppj,num2str(j),'\IBSR_',ppj,num2str(j),'.nii');

                if i~=j && isfile(movingImagePath)
                    
                    clear movingImage;
                    clear movingImage1;
                    movingImage = double(niftireadB(movingImagePath));
                    movingImage(movingImage<0) = 0;
                    

%                      d(tur) = ssim(movingImage,fixedImage );
                       d(tur) = ssim(movingImage(64:192,32:96,64:192),fixedImage(64:192,32:96,64:192) );
                      jss(tur) = j;
                      tur=tur+1;
                     
                end
                             
            end
       
            
            d
            jss = sortBlikeA(d,jss);

            d = sort(d,'descend');
            
            jss = jss .* (d>max(d)-(max(d)-mean(d))/Thresh);
%             disp('The chosen Images for Registration are ');
%             jss(jss>0)
            stats(:,turr) = [mean(d) std(d).^2 std(d) max(d)-(max(d)-mean(d))/Thresh i];
            turr = turr+1;
        end
    end
    
%     stats

    outputArg1 =  jss(jss>0) ;
    if size(outputArg1,2) == 2 && strcmp(method, 'vote')
        
        tmp = preRegistration(inputArg1,method,0.5);
        outputArg1 = [outputArg1 tmp(3)];
    end
    
    disp('The chosen Images for Registration are ');
    outputArg1
end
