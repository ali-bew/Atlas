clear all;close all;
warning('off');
N=40;
dimension=1;
classes=3;
rgbImage = false;
rgbPath='kobi.png';
rgbScale = 0.25;
PreviewResults = 1 ; % 0 No results , 1 show per Image , 2 show iterations in Slice
maxIterations = 200;
maxSlices = 1;
LabelImagesMethod = 'LabelDice' ; % SortingMeans or LabelDice or SortingMeansDefined
kmeansReplicates =50; %use less replicates when using kmeaniterations > 1
KmeanIterations = 3;
lambda = 0.01;
randomN = 20;
combined = true;
% the init method defines how to initialize 
% kmeans , random , cheating , randomN
% - random is defining random means but based on our given Image (minimum of intensity , middle and max ..)
% - cheating is taking the labels from the Image Label, this should give the
%    best results but shall not be used in real application
% - randomN is trying N times for each slice and take best result
% - labelpropagate starting from label propagation
% - tissuemodel starting from tissue models
% - labelpropagatetissuemodel starting from label propagation and tissue models
initMethod = 'labelpropagatetissuemodel'; 

% - Below are the file names
% - if you want extra dimension just add the path to dimen with the variable
%   number as excalamtion mark


dimen(1) = "C:\Users\developer\Desktop\bew\Courses Girona\Project ISA - MIRA\Data\Training_Set\IBSR_!\IBSR_!.nii" ;
dimen(2) = "test/!/T2_FLAIR.nii" ;
labeling = "C:\Users\developer\Desktop\bew\Courses Girona\Project ISA - MIRA\Data\Training_Set\IBSR_!\IBSR_!_seg.nii" ;
dimenResult = strcat("C:\Users\developer\Desktop\bew\Courses Girona\Project ISA - MIRA\Data\resultEM\!",initMethod,".nii") ;
info3=niftiinfo('C:\Users\developer\Desktop\bew\Courses Girona\Project ISA - MIRA\Data\Training_Set\IBSR_01\IBSR_01.nii');
labelpropagatePath = "C:\Users\developer\Desktop\bew\Courses Girona\Project ISA - MIRA\Data\results1\label1!\result.nii";
tissuemodelPath = "C:\Users\developer\Desktop\bew\Courses Girona\Project ISA - MIRA\Data\results2\label1!\result.nii";
labelpropagatetissuemodelPath = "C:\Users\developer\Desktop\bew\Courses Girona\Project ISA - MIRA\Data\results3\label!\result.nii";
labelpropagatetissuemodelPath1 = "C:\Users\developer\Desktop\bew\Courses Girona\Project ISA - MIRA\Data\results3\label!\prob1result.nii";
labelpropagatetissuemodelPath2 = "C:\Users\developer\Desktop\bew\Courses Girona\Project ISA - MIRA\Data\results3\label!\prob2result.nii";
labelpropagatetissuemodelPath3 = "C:\Users\developer\Desktop\bew\Courses Girona\Project ISA - MIRA\Data\results3\label!\prob3result.nii";
% w1 = 1;
% w2 = 1;
% w3 = 1;

w1 = 1.4;
w2 = 0.8;
w3 = 0.1;


if rgbImage 
    N=1;
    slices=1;
    dimension=3;
    maxSlices = 1;
end

    


% VolumeDiceDistance = zeros(N,5); %it contains Dice mean and deviation of each Image
tic
tur = 0;
for fil=0:N
    if fil < 10
        pii = strcat('0',num2str(fil));% this is for path reading
    else
        pii = num2str(fil);
    end 
    
  if isfile(strrep(dimen(1),"!",pii))
    tur = tur+1;
    if rgbImage
    %
    else  
        %reading Images
        clear VImages;
        for diii=1:dimension
            VImages(:,:,:,diii) = niftiread( strrep(dimen(diii),"!",pii));
        end
        %reading header to place it in result
        infoHeader = niftiinfo( strrep(dimen(1),"!",pii));
        %reading labels
        Vl = niftiread( strrep(labeling,'!',pii));
    end
    
    %this vector will contain norm2 distance for each slice
    SliceDiceDistance = zeros(maxSlices,1); %Norm2 distance
    rN = 1;
    slice=1;
while(slice <= maxSlices)
  
   %rN is used for RandomN 
  rN=mod(rN,randomN);
 
   if rgbImage
        RGB = imread(rgbPath);
        RGB = imresize(RGB,rgbScale);
        ImageLabel = imsegkmeans(RGB,classes) ;
        figure
        imshow(RGB)
        title('Original')
   
        Mask = ones(size(ImageLabel));
        Image(:,:,1)=RGB(:,:,1);
        Image(:,:,2)=RGB(:,:,2);
        Image(:,:,3)=RGB(:,:,3);
        Mask = double(reshape(Mask(:,:,1),[],1));
   else
       
       
    ImageLabel = Vl;
    MaskImage = ImageLabel==0;
    Mask = 1 - MaskImage;
    
    
    %from Image Mask to vector
    Mask = double(reshape(Mask(:,:,:),[],1));
    
    clear Image;
    clear Membership;
    clear Iout;
    %reading the slice
    for diii=1:dimension
       
        Image(:,:,:,diii)=VImages(:,:,:,diii);
       
    end

   end
    
for di=1:dimension
    
    %from Image to vector
    if not(rgbImage)
        if di == 1 
          V = double(Image(Mask>0));
        else
          tmp = Image(:,:,:,di);
          V = [V double(tmp(Mask>0))];
        end
    end
    
    %from Image to vector rgb
    if rgbImage
        if di == 1 
          V = double(Image(Mask>0));
        else
          tmp = Image(:,:,di);
          V = [V double(tmp(Mask>0))];
        end
    end
end

if strcmp(initMethod,'kmeans')

    [Klabels,Kmeans] = kmeans(V,classes,'Replicates',kmeansReplicates);

    if KmeanIterations > 1
        KPL = Klabels;
        KPM = Kmeans;
        for km =2:KmeanIterations
           [KPLtmp,KPMtmp] = kmeans(V,classes,'Replicates',kmeansReplicates); 
            KPL = KPL + KPLtmp;
            KPM = KPM + KPMtmp;
        end

        Klabels = round(double(double(KPL)/KmeanIterations));
        Kmeans = double(double(KPM)/KmeanIterations);


      
    end 

Membership = zeros(size(V,1),classes);
%Membership = Klabels;


    for it=1:classes
            Membership(:,it) = Klabels==it;  
    end
    
    %the below step is important in case some pixels were not given a class
    %in kmean and they are not in the MASK ( they should have a class )
%     [M,I] = max(Membership,[],2);
%     for it=1:classes
%          Membership(:,it)= I==it;  
%     end 


elseif strcmp(initMethod,'random')
    Membership = zeros(size(V,1),classes);
    for it=1:classes
        Membership(:,it) = rand(size(V,1),1);
    end 
    [M,I] = max(Membership,[],2);
    for it=1:classes
         Membership(:,it)= I==it;  
    end

    
elseif strcmp(initMethod,'randomN')
    Membership = zeros(size(V,1),classes);
    for it=1:classes
        Membership(:,it) = rand(size(V,1),1);
    end 
    [M,I] = max(Membership,[],2);
    for it=1:classes
         Membership(:,it)= I==it;  
    end

    
elseif  strcmp(initMethod,'cheating')
    Membership = zeros(size(V,1),classes);
    for it=1:classes
%         Membership(:,it) = ImageLabel==it;  
        Membership(:,it) = (ImageLabel(Mask>0))==it;
    end    
elseif strcmp(initMethod,'labelpropagate')
    Imagelabelpropagate = niftiread( strrep(labelpropagatePath,'!',num2str(fil)));
    for it=1:classes
%         Membership(:,it) = ImageLabel==it;  
        Membership(:,it) = (Imagelabelpropagate(Mask>0))==it;
    end 
elseif strcmp(initMethod,'tissuemodel')
    Imagetissuemodel = niftiread( strrep(tissuemodelPath,'!',num2str(fil)));
    for it=1:classes
%         Membership(:,it) = ImageLabel==it;  
        Membership(:,it) = (Imagetissuemodel(Mask>0))==it;
    end
elseif strcmp(initMethod,'labelpropagatetissuemodel')
    Imagelabelpropagatetissuemodel = niftiread( strrep(labelpropagatetissuemodelPath,'!',num2str(fil)));
    for it=1:classes
%         Membership(:,it) = ImageLabel==it;  
        Membership(:,it) = (Imagelabelpropagatetissuemodel(Mask>0))==it;
    end
end

Nk = getNk(Membership,classes);

means = returnMean(Membership,V,Nk,classes);

alpha=returnAlpha(Membership,classes);

covariance = returnCovariance(means,Membership,V,Nk,classes,dimension);


if PreviewResults == 1
    disp(' ');
    disp(' ');
    disp(strcat('File      #',num2str(fil)));
    disp(strcat ('initial Nk        : ' ,  num2str(uint32(Nk))));
    disp(strcat ('initial mean      : ' , num2str(means)));
    disp(strcat ('initial alpha     : ' , num2str(alpha)));
    disp(strcat ('initial covariance: ' , num2str(covariance)));
end

%for convergence
oldMean = means;
oldMean=zeros;
IterationsNeeded = maxIterations;


%engineer this
    
    XX1 = niftiread( strrep(labelpropagatetissuemodelPath1,'!',num2str(fil)));
    X1 = (XX1(Mask>0));
    XX2 = niftiread( strrep(labelpropagatetissuemodelPath2,'!',num2str(fil)));
    X2 = (XX2(Mask>0));
    XX3 = niftiread( strrep(labelpropagatetissuemodelPath3,'!',num2str(fil)));
    X3 = (XX3(Mask>0));
    
for it = 1:maxIterations
    if combined == true
        Membership = returnMembership(alpha,means,covariance,V,classes,X1*w1,X2*w2,X3*w3);
    else
        Membership = returnMembership(alpha,means,covariance,V,classes);
    end

    Nk = getNk(Membership,classes);

    means = returnMean(Membership,V,Nk,classes);

    alpha=returnAlpha(Membership,classes);

    covariance = returnCovariance(means,Membership,V,Nk,classes,dimension);
    
    %this is for preview
    converged=false;
    
    
    if norm(oldMean - means)<=lambda
        converged=true;
    end
    
    if PreviewResults == 2
        disp(' ');
        disp(' ');
        disp(strcat('File      #',num2str(fil)));
        disp(strcat('Slice     #',num2str(slice)));
        disp(strcat('Iteration #',num2str(it)));
        disp(strcat ('Nk        : ' ,  num2str(uint32(Nk))));
        disp(strcat ('mean      : ' , num2str(means)));
        disp(strcat ('alpha     : ' , num2str(alpha)));
        disp(strcat ('covariance: ' , num2str(covariance)));
    end
    
    if PreviewResults == 1 && (it >= maxIterations || converged)
        disp(' ');
        disp(' ');
        disp(strcat('File      #',num2str(fil)));
        disp(strcat('Slice     #',num2str(slice)));
        disp(strcat('Iteration #',num2str(it)));
        disp(strcat ('Nk        : ' ,  num2str(uint32(Nk))));
        disp(strcat ('mean      : ' , num2str(means)));
        disp(strcat ('alpha     : ' , num2str(alpha)));
        disp(strcat ('covariance: ' , num2str(covariance)));
    end
    
    
    if converged
        IterationsNeeded = it;
        break;
    end
    oldMean = means;

        
end

%here we evaluate
    if strcmp(LabelImagesMethod ,'SortingMeans')
        meansNotSorted = means(1,:);
        meansSorted = sort(meansNotSorted,'ascend');
        I =  Membership(:,1)*find(meansSorted == meansNotSorted(1),1);
        %I =  Membership(:,1)*find(meansSorted == meansNotSorted(1),1);
        for it=2:classes
            I = I + Membership(:,it)*find(meansSorted == meansNotSorted(it),it);
%             I = I + Mask.*Membership(:,it)*find(meansSorted == meansNotSorted(it),1);        
        end
%         Iout(:,:,slice) = reshape(I,[size(Image(:,:,1),1),size(Image(:,:,1),2)]);
            tmpIout = zeros(size(Image(:,:,:,1)));
            tmpIout(MaskImage==0) = I;

            Iout(:,:,:) = tmpIout;
    elseif strcmp(LabelImagesMethod ,'SortingMeansDefined')
        meansNotSorted = means(1,:);
        meansSorted = sort(meansNotSorted,'ascend');
        I =  Membership(:,1)*find(meansSorted == meansNotSorted(2),1);
        I =  I + Membership(:,2)*find(meansSorted == meansNotSorted(3),1);
        I =  I + Membership(:,3)*find(meansSorted == meansNotSorted(1),1);
        
%         %I =  Membership(:,1)*find(meansSorted == meansNotSorted(1),1);
%         for it=2:classes
%             I = I + Membership(:,it)*find(meansSorted == meansNotSorted(it),it);
% %             I = I + Mask.*Membership(:,it)*find(meansSorted == meansNotSorted(it),1);        
%         end
% %         Iout(:,:,slice) = reshape(I,[size(Image(:,:,1),1),size(Image(:,:,1),2)]);
            tmpIout = zeros(size(Image(:,:,:,1)));
            tmpIout(MaskImage==0) = I;

            Iout(:,:,:) = tmpIout;
    elseif strcmp(LabelImagesMethod ,'LabelDice')

        bestSeg = 1;
        bestDice = 0;
        Permutation = perms(1:classes);
        for seg = 1 : factorial(classes)
            I =  Membership(:,1)*Permutation(seg,1);
            for it=2:classes
                I = I + Membership(:,it)*Permutation(seg,it);       
            end

            %reconstructing

            tmpIout = zeros(size(Image(:,:,:,1)));
            tmpIout(MaskImage==0) = I;
            tmpDice = dice(double(tmpIout),double(ImageLabel)); 
            tmpDice
            if mean(tmpDice) > bestDice
                bestDice = norm(tmpDice)/size(tmpDice,1);
                bestSeg = seg;
            end

        end
        I =  Membership(:,1)*Permutation(bestSeg,1);
        for it=2:classes
            I = I + Membership(:,it)*Permutation(bestSeg,it);       
        end
            tmpIout = zeros(size(Image(:,:,:,1)));
            tmpIout(MaskImage==0) = I;

            Iout(:,:,:) = tmpIout;


    end
%this is temp
tmp = Iout(:,:,:);
tmp(tmp==1)=4;
tmp(tmp==2)=5;
tmp(tmp==3)=6;
tmp(tmp==4)=3;
tmp(tmp==5)=1;
tmp(tmp==6)=2;
% Iout(:,:,:) = tmp ;
tDice = dice(double(Iout(:,:,:)),double(ImageLabel));
% tDice
if strcmp(initMethod,'randomN')
    if norm(tDice)/sqrt(size(tDice,1)) > SliceDiceDistance || isnan(norm(tDice)/sqrt(size(tDice,1)))
        SliceDiceDistance = norm(tDice)/sqrt(size(tDice,1));  
        SliceDiceDistance(isnan(SliceDiceDistance))=1;
    end
else
    SliceDiceDistance = norm(tDice)/sqrt(size(tDice,1));  
    SliceDiceDistance(isnan(SliceDiceDistance))=1;
    SliceDiceDistance
end
% figure;
% imshow(Iout(:,:,slice),[]);
% figure;
% imshow(ImageLabel,[]);
%stop iterating if the dice value was perfect which is 0.8
if mod(rN,randomN) > 0 && strcmp(initMethod,'randomN') && SliceDiceDistance < 0.8
    slice = slice-1;
end
rN = rN+1;

slice=slice+1;
end
VolumeDiceDistance(tur,1) = mean(SliceDiceDistance);
VolumeDiceDistance(tur,2) = IterationsNeeded;
VolumeDiceDistance(tur,3:5) = tDice;

nam ='';
if combined
    nam = 'combined';
end
if w1 ~=1 || w2 ~=1 || w3 ~=1 
    nam = 'combinedweighted';
end

if not(rgbImage)
%    niftiwrite(int16(Iout),strrep(dimenResult,"!",num2str(fil)),infoHeader); 
    niftiwrite(single(int16(Iout)),strrep(dimenResult,"!",strcat(num2str(fil),nam)),setInfo(info3,int16(Iout)));
end


if rgbImage
    figure
    imshow(Iout(:,:,slice-1),[])
    title('Segmented')
    figure
    imshow(ImageLabel,[])
    title('Label')
    
end

end
end
toc
VolumeDiceDistance

