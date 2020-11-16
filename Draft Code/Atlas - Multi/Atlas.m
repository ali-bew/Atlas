function [outputArg1] = Atlas(inputArg1,method,Threshold,Weighted)

N = 20 ; % number of files in training data
currentFolder = 'C:\Users\developer\Desktop\bew\Courses Girona\Project ISA - MIRA';
imageResultName = 'result.1.nii';
labelResultName = 'result.nii';
classes=3;
tur = 1;
outPath = strcat(currentFolder ,'\Data\results\');
info3 = 'C:\Users\developer\Downloads\output3\result.1.nii';
info4 = 'C:\Users\developer\Downloads\MNITemplateAtlas\atlas.nii\atlas.nii';

%
if inputArg1 < 10
    ppi = '0';% this is for path reading
else
    ppi = '';
end
mask = niftireadB(strcat(currentFolder , '\Data\Validation_Set\IBSR_',ppi,num2str(inputArg1),'\IBSR_',ppi,num2str(inputArg1),'_mask.nii'));
%

if nargin > 0
    arrI = preRegistration(inputArg1,method,Threshold);
end

    for i = 0:N %i is the fixed image 
        
        if i < 10
            ppi = '0';% this is for path reading
        else
            ppi = '';
        end
        
        if ~ismember(i,arrI)
                i=999;
        end
            
        % al folders containing in directory results are the source files 
        % source of registration 
        LabelFolder = strcat(strcat(currentFolder ,'\Data\results\label'),num2str(i)); 
        LabelPath = strcat(LabelFolder,'\',labelResultName);
       

        ImageFolder = strcat(strcat(currentFolder ,'\Data\results\output'),num2str(i)); 
        ImagePath = strcat(ImageFolder,'\',imageResultName);
        
        if isfile(ImagePath)
            
            L = niftireadB(LabelPath);
            I = niftireadB(ImagePath);
            I(I<0)=0;
            %
%              L(mask~=0 & L==0 & I > ( mode(I(I>0),'all')-0) & I < ( mode(I(I>0),'all')+0))=2;
            %
            wMax = 1;
            if Weighted
                wMax = size(arrI,2) - find(arrI == i) + 1;
            end
          
            for w =1:wMax
                atlasI(:,:,:,tur) = I;                      
                atlasL(:,:,:,tur) = L;
                tur = tur + 1;
               
            end
        end
        
    end
   
atlas(:,:,:,1) = mean(atlasI,4);%no need for this it is not used since we are registering to the target image
if strcmp(method,'probability')
%     atlas(:,:,:,1) = mean(atlasI,4);
    for it = 2:classes + 1
        atlas(:,:,:,it) = mean(atlasL == (it-1), 4);
    end
elseif strcmp(method,'vote')
%     atlas(:,:,:,1) = mode(atlasI,4);%no need for this it is not used since we are registering to the target image
    for it = 2:classes + 1
        atlas(:,:,:,it) = mode(uint8(atlasL == (it-1)), 4);
    end
end

    
    
%     atlas = flip(atlas,2);
    niftiwriteB(atlas,info4,strcat(outPath,'probAtlas.nii'));
   

La = atlas(:,:,:,2:4); %labels
Laz = sum(La,4); % labels used for mask ( the sum is to determine the zero values)
[maxvalue,maxindex] = max(La,[],4);

Imm = atlas(:,:,:,1); % intensity image

Im = Imm(Laz >0); % intensity image with mask vector
ind = maxindex(Laz >0); % segmented Image with mask vector 

%this is for writing the segmented Image(by segmented i mean the maximum probabilities)

SegmentedLabel = zeros(size(Imm));
SegmentedLabel(Laz>0) = ind;
% SegmentedLabel = flip(SegmentedLabel,2);
niftiwriteB(SegmentedLabel,info3,strcat(outPath,'probAtlasLabel.nii'));

%writing the mask
probAtlasMask = zeros(size(Imm));
probAtlasMask(Laz == 0) = ones;
probAtlasMask = probAtlasMask==0;
% probAtlasMask = flip(probAtlasMask,2);
niftiwriteB(probAtlasMask,info3,strcat(outPath,'probAtlasMask.nii'));

%writing the intensity Image
% Imm = flip(Imm,1);
% Imm = flip(Imm,2);
% Imm = flip(Imm,3);
niftiwriteB(Imm,info3,strcat(outPath,'probAtlasImage.nii'));


for it=2:classes+1
%     atlas(:,:,:,it) = flip(atlas(:,:,:,it),2);
    niftiwriteB(atlas(:,:,:,it),info3,strcat(outPath,'probAtlasLabel',num2str(it-1),'.nii'));
end

for it=2:classes+1
%     atlas(:,:,:,it) = flip(atlas(:,:,:,it),2);
    niftiwriteB(atlas(:,:,:,it)*15000 ,info3,strcat(outPath,'probAtlasLabel',num2str(it-1),'_.nii'));
    niftiwriteB(atlas(:,:,:,it) ,info3,strcat(outPath,'probAtlasLabelProb',num2str(it-1),'.nii'));
end


%plot the Intensity tissue models
figure
hold on,

for it=1:classes           
    histo = histogram((Im(ind == it)),'Normalization','pdf','DisplayStyle','stairs');
end
end

