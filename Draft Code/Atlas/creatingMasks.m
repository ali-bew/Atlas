clear all; close all;
N = 20 ; % number of files in training data
currentFolder = 'C:\Users\developer\Desktop\bew\Courses Girona\Project ISA - MIRA\Data';
deleteAfterDone = false;
imageResultName = 'result.1.nii';
labelResultName = 'result.nii';

    for i = 0:N %i is the fixed image, the loop is for testing all atlases choices
        
        if i < 10
            ppi = '0';% this is for path reading
        else
            ppi = '';
        end
        
        filename = strcat(currentFolder , '\Training_Set\IBSR_',ppi,num2str(i),'\IBSR_',ppi,num2str(i),'.nii');
        if isfile(filename)
            
            info = niftiinfo(filename);
            trtr = load_untouch_nii(filename);
            im = trtr.img;
%           im = niftiread(info);
           
            
            mask = im==0;
            mask = 1 -mask;
            fname = strrep(filename,'.nii','_mask.nii');
            trtr.img = mask;
%             niftiwrite(int16(mask),fname,setInfo(info,mask,fname,'int16'));
            save_untouch_nii(trtr,fname)


        end
        
  
end

