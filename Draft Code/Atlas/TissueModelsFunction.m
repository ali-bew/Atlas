function [Table] = TissueModelsFunction()

N = 40 ; % number of files in training data
currentFolder = 'C:\Users\developer\Desktop\bew\Courses Girona\Project ISA - MIRA';
classes=3;


atlasImagePath = strcat(currentFolder ,'\Data\results\probAtlasImage.nii');
atlasLabelPath = strcat(currentFolder ,'\Data\results\probAtlasLabelProb!.nii');


atlas(:,:,:,1) = niftireadB(atlasImagePath); 
for it = 1:classes
    atlas(:,:,:,it+1) = niftireadB(strrep(atlasLabelPath,'!',num2str(it)));
end


  
    
La = atlas(:,:,:,2:classes+1); %labels
Laz = sum(La,4); % labels used for mask ( the sum is to determine the zero values)
[maxvalue,maxindex] = max(La,[],4);

Imm = atlas(:,:,:,1); % intensity image
 
Im = Imm(Laz >0); % intensity image with mask vector
ind = maxindex(Laz >0); % segmented Image with mask vector 

% column 1 is the intensity values
% column 2 to 4 are hte classes probabilities
% column 5 is the maximum selected class

Table (1:65536,1)=1:65536;
Table (1:65536,2)=zeros;
Table (1:65536,3)=zeros;
Table (1:65536,4)=zeros;
Table (1:65536,5)=zeros;
    
tbl1 = tabulate(uint16(Im(ind == 1)));
tbl2 = tabulate(uint16(Im(ind == 2)));
tbl3 = tabulate(uint16(Im(ind == 3)));
    
%creating the table
clear t1;
clear t2;
clear t3;
%for class1
t1 = tbl1(:,1);
%     t2 = tbl1(:,2);
t3 = tbl1(:,3);

    for i =1:5000
        v = find(t1==(i-1),1);
        
        if isempty(v)
            Table(i,2) = 0;
        else
            Table(i,2) = t3(v,1);
        end
    end

    
clear t1;
clear t2;
clear t3;
%for class2
t1 = tbl2(:,1);
%     t2 = tbl2(:,2);
t3 = tbl2(:,3);
    for i =1:5000
        v = find(t1==(i-1),1);
        
        if isempty(v)
            Table(i,3) = 0;
        else
            Table(i,3) = t3(v,1);
        end   
    end

    
clear t1;
clear t2;
clear t3;
%for class3
t1 = tbl3(:,1);
%     t2 = tbl3(:,2);
t3 = tbl3(:,3);
    for i =1:5000
        v = find(t1==(i-1),1);
        
        if isempty(v)
            Table(i,4) = 0;
        else
            Table(i,4) = t3(v,1);
        end
    end
   
[f,Table(:,5)] = max(Table(:,2:4),[],2);

   for i =1:5000       
        if (Table(i,2) + Table(i,3) + Table(i,4))==0 
            Table(i,5)=0;
        end
   end
   %since our data maximum intensity is not greater than 5000 ( actually 2500)
    Table(5000:65536,5)=zeros;
    
    
return
    
    
    
    
    
    
    
    
    
    
    
    


end

