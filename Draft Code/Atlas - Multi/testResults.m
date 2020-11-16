function [outputArg1] = testResults(inputArg1)
tur = 0;
N = 20 ; % number of files in Validation data
currentFolder = 'C:\Users\developer\Desktop\bew\Courses Girona\Project ISA - MIRA';
compareResult = 13;

% segtrue = niftireadB('C:\Users\developer\Desktop\bew\Courses Girona\Project ISA - MIRA\Data\Validation_Set Orig\IBSR_13\IBSR_13_seg.nii');
% % re = niftireadB('C:\Users\developer\Desktop\bew\Courses Girona\Project ISA - MIRA\Data\results3\label13\result.nii');
%  ref = niftireadB('C:\Users\developer\Desktop\bew\Courses Girona\Project ISA - MIRA\Data\Validation_Set Orig\IBSR_13\IBSR_13.nii');
%  a= 'C:\Users\developer\Desktop\bew\Courses Girona\Project ISA - MIRA\Data\Validation_Set Orig\IBSR_13\IBSR_13_seg.nii';
%  b='C:\Users\developer\Desktop\bew\Courses Girona\Project ISA - MIRA\Data\resultWrong.nii';
% img = ref;
% img = zeros;
%  img(segtrue~=0 & ref==0)=1;
% niftiwriteB(img,a,b);
% % dice(double(img),double(ref))
% % img=ref==resu;
% % niftiwriteB(double(img),a,b);
% return
j=inputArg1;
            
            if j < 10
            ppj = '0';% this is for path reading
        else
            ppj = '';
            end
        
labelatlasPath = strcat(currentFolder ,'\Data\results\probAtlasLabel.nii');
labeltruthPath = strcat(currentFolder , '\Data\Validation_Set\IBSR_',ppj,num2str(j),'\IBSR_',ppj,num2str(j),'_seg.nii');

if isfile(labeltruthPath)
    tur = tur + 1;
    masktruthPath = strcat(currentFolder , '\Data\Validation_Set\IBSR_',ppj,num2str(j),'\IBSR_',ppj,num2str(j),'_mask.nii');
    labelpropagatetissuemodelPath = strcat(currentFolder ,'\Data\results3\label',num2str(j),'\result.nii');
    labeltissuemodelPath = strcat(currentFolder ,'\Data\results2\label',num2str(j),'\result.nii');
    labelpropagatePath = strcat(currentFolder ,'\Data\results1\label',num2str(j),'\result.nii');



    labelatlas = niftireadB(labelatlasPath);
    labeltruth = niftireadB(labeltruthPath);

    masktruth = niftireadB(masktruthPath);
    % labelpropagatetissuemodel = niftireadB(labelpropagatetissuemodelPath);
    % labeltissuemodel = niftireadB(labeltissuemodelPath);
    % labelpropagate = niftireadB(labelpropagatePath);



    if isfile(labelpropagatePath) 
        labelpropagate = niftireadB(labelpropagatePath);
        disp(strcat(num2str(j),' labelpropagate'));
        td=dice(double(labeltruth),double(labelpropagate));
        VolumeDiceDistance1(tur,1) = mean(td);
%         HausdorffDist(double(labeltruth(labeltruth>-1)),double(labelpropagate(labelpropagate>-1)))
        VolumeDiceDistance1(tur,2:4) = td;
        
        if j == compareResult
            
            outputf = strcat(currentFolder,'\Data\CompareResults');
            mkdir(outputf);
            niftiwriteB(double(labelpropagate==labeltruth),labelpropagatePath,strcat(outputf,'\LP',num2str(j),'.nii'));
            
            
        end
    end
outputArg1 = VolumeDiceDistance1;

%     if isfile(labeltissuemodelPath) 
%         labeltissuemodel = niftireadB(labeltissuemodelPath);
%         disp(strcat(num2str(j),' labeltissuemodel'));
%         td=dice(double(labeltruth),double(labeltissuemodel));
%         VolumeDiceDistance2(tur,1) = mean(td);
% 
%         VolumeDiceDistance2(tur,2:4) = td;
%         
%         if j == compareResult
%             
%             outputf = strcat(currentFolder,'\Data\CompareResults');
%             mkdir(outputf);
%             niftiwriteB(double(labeltissuemodel==labeltruth),labeltissuemodelPath,strcat(outputf,'\TM',num2str(j),'.nii'));
%             
%             
%         end
%     end


%     if isfile(labelpropagatetissuemodelPath) 
%         labelpropagatetissuemodel = niftireadB(labelpropagatetissuemodelPath);
%         disp(strcat(num2str(j),' labelpropagatetissuemodel'));
%         td = dice(double(labeltruth),double(labelpropagatetissuemodel));
%         VolumeDiceDistance3(tur,1) = mean(td);
% 
%         VolumeDiceDistance3(tur,2:4) = td;
%         
%         if j == compareResult
%             
%             outputf = strcat(currentFolder,'\Data\CompareResults');
%             mkdir(outputf);
%             niftiwriteB(double(labelpropagatetissuemodel==labeltruth),labelpropagatetissuemodelPath,strcat(outputf,'\LPTM',num2str(j),'.nii'));
%             
%             
%         end
%     end
end
end
% ssim(double(labeltruth),double(labeltissuemodel).*double(masktruth))

% VolumeDiceDistance1
% VolumeDiceDistance2
% VolumeDiceDistance3
