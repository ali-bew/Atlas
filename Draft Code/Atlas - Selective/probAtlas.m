
clear all;close all;
N = 20 ; % number of files in training data
currentFolder = 'C:\Users\developer\Desktop\bew\Courses Girona\Project ISA - MIRA';
imageResultName = 'result.1.nii';
labelResultName = 'result.nii';
classes=3;
tur = 1;
outPath = strcat(currentFolder ,'\Data\results\');
info3 = 'C:\Users\developer\Desktop\bew\Courses Girona\Project ISA - MIRA\Data\results\output1\result.1.nii';
info4 = 'C:\Users\developer\Downloads\MNITemplateAtlas\atlas.nii\atlas.nii';

for i = 0:N 
        
        if i < 10
            ppi = '0';% this is for path reading
        else
            ppi = '';
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
            atlasL(:,:,:,tur) = L;
            atlasI(:,:,:,tur) = I;
            
            tur = tur + 1;
        end
        
end

    atlas(:,:,:,1) = mean(atlasI,4);
    for it = 2:classes + 1
        atlas(:,:,:,it) = mean(atlasL == (it-1), 4);
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


