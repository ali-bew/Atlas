function [outputArg1] = preRegistration(inputArg1)
close all;clear all;
N = 40 ; % maximum index of files in training data
currentFolder = 'C:\Users\developer\Desktop\bew\Courses Girona\Project ISA - MIRA';
starting = 0;
if nargin > 0
    starting = inputArg1;
    N = inputArg11;
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
%         fixedImagePath = strcat('C:\Users\developer\Desktop\bew\Courses Girona\Project ISA - MIRA\Data\resultsRigid\output',num2str(i),'\result.0.nii');
        
        if isfile(fixedImagePath)
            
            fixedImage = double(niftireadB(fixedImagePath));
            fixedImage(fixedImage<0) = 0;
%             figure;
%              histogram((fixedImage(fixedImage>0)),'Normalization','pdf','DisplayStyle','stairs');
%                     
            for j = 0:N    
                if j < 10
                    ppj = '0';% this is for path reading
                else
                    ppj = '';
                end
                movingImagePath = strcat(currentFolder , '\Data\Training_Set\IBSR_',ppj,num2str(j),'\IBSR_',ppj,num2str(j),'.nii');
%                  movingImagePath = strcat('C:\Users\developer\Desktop\bew\Courses Girona\Project ISA - MIRA\Data\resultsRigid\output',num2str(j),'\result.0.nii');

                if i~=j && isfile(movingImagePath)
                    clear movingImage;
                    clear movingImage1;
                    movingImage = double(niftireadB(movingImagePath));
                    movingImage(movingImage<0) = 0;
                    
%                     movingImage1 = imhistmatchn(movingImage,fixedImage);
                 
%                    trtr = load_untouch_nii(fixedImagePath);

%                     trtr.img = movingImage1;
%                     fname = strcat('C:\Users\developer\Desktop\bew\Courses Girona\Project ISA - MIRA\Data\HistMatch\',num2str(i),'-',num2str(j),'.nii');
%                     save_untouch_nii(trtr,fname);
                   
                      d(tur) = ssim(movingImage(64:192,32:96,64:192),fixedImage(64:192,32:96,64:192) );
                      jss(tur) = j;
                      %                     d(tur) = corr3d(movingImage(:,:,:),fixedImage(:,:,:));
%                      d(tur) = (sum((movingImage*(mean(fixedImage,'all')/mean(movingImage,'all'))-fixedImage).^2,'all'))/1000000;
                    tur=tur+1;

                end
                             
            end
            i
            
           
%             mean(fixedImage(fixedImage>0),'all')
%             std(fixedImage(fixedImage>0),1,'all')
%             uint8((sum(fixedImage>0,'all'))/double(sum(fixedImage>-1,'all'))*100)
            
%             d>max(d)-(max(d)-mean(d))/(pi/2)
            d
%             d(d>max(d)-(max(d)-mean(d))/(pi/2))
            jss = jss .* (d>max(d)-(max(d)-mean(d))/(pi/2));
            jss
            stats(:,turr) = [mean(d) std(d).^2 std(d) max(d)-(max(d)-mean(d))/sqrt(2) i];
            turr = turr+1;
        end
    end
    
    stats
    outputArg1 =  jss(jss>0) ;
    outputArg1
end
