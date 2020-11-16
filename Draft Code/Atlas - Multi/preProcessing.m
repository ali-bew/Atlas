
N = 40 ; % maximum index of files in training data
currentFolder = 'C:\Users\developer\Desktop\bew\Courses Girona\Project ISA - MIRA';


 
        tur = 1;
                         
            for j = 0:N    
                if j < 10
                    ppj = '0';% this is for path reading
                else
                    ppj = '';
                end
                movingImagePath = strcat(currentFolder , '\Data\Validation_Set\IBSR_',ppj,num2str(j),'\IBSR_',ppj,num2str(j),'.nii');

                if  isfile(movingImagePath) %i~=j
                     
                    clear movingImage;
                    clear movingImage1;
                    movingImage = double(niftireadB(movingImagePath));
                    movingImage(movingImage<0) = 0;
          
                    if max(movingImage,[],'all')> 255      
                        niftiwriteB(uint8(double(movingImage)./double(max(double(movingImage),[],'all')).*255),movingImagePath,movingImagePath);
                        tur=tur+1;
                       
                    end
                end
                             
            end

            
      
   


