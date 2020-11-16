% 
% 
% 
% Im = Imm(Laz >0); % intensity image with mask vector
% ind = maxindex(Laz >0); % segmented Image with mask vector 
% 
% La = atlas(:,:,:,2:4); %labels
% Laz = sum(La,4); % labels used for mask ( the sum is to determine the zero values)
% [maxvalue,maxindex] = max(La,[],4);
% 
% L = niftireadB(LabelPath);
% Imm = atlas(:,:,:,1); % intensity image
% 
% Im = Imm(Laz >0); % intensity image with mask vector
ind = niftireadB('C:\Users\developer\Desktop\bew\Courses Girona\Project ISA - MIRA\Data\Validation_Set Orig\IBSR_13\IBSR_13_seg.nii');
Im = niftireadB('C:\Users\developer\Desktop\bew\Courses Girona\Project ISA - MIRA\Data\Validation_Set Orig\IBSR_13\IBSR_13.nii');

figure
hold on,

for it=1:classes           
    histo = histogram((Im(ind == it)),'Normalization','pdf','DisplayStyle','stairs');
end



atlasImagePath = strcat(currentFolder ,'\Data\results\probAtlasImage.nii');
atlasLabelPath = strcat(currentFolder ,'\Data\results\probAtlasLabel.nii');



atlas = niftireadB(atlasImagePath); 
atlasLabel = niftireadB(atlasLabelPath); 
movingImage = atlas;
movingImage1 = movingImage;
%apply excluding the mask
if mean(movingImage(movingImage>0),'all')<150
    movingImage1(movingImage1>0) = movingImage(movingImage>0) + 150 - mean(movingImage(movingImage>0),'all');
2
end
atlas = movingImage1;


figure
hold on,

for it=1:classes           
    histo = histogram((atlas(atlasLabel == it)),'Normalization','pdf','DisplayStyle','stairs');
end
