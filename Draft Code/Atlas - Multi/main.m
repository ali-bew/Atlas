logg('       ----------------------------------------------------------------------------');
diary 'C:\Users\developer\Desktop\bew\Courses Girona\Project ISA - MIRA\LogCommandOutput.txt'
diary on
clear all; close all;
currentFolder = 'C:\Users\developer\Desktop\bew\Courses Girona\Project ISA - MIRA';
Thresh = (5/2); %increase the value for less choices
method = 'vote';
weighted = true;
Reregister = true;
creatingMasks
preProcessing
tur = 1;
for j = 1:1
Thresh = -0.45 + 0.5*j;
logg(strcat('Thresh value :',num2str(Thresh)));
logg(strcat('Method value :',num2str(method)));
logg(strcat('Weighted value :',num2str(weighted)));
logg(strcat('Reregister value :',num2str(Reregister)));

arr = [15 22]
% arr = [11]

for i=1:size(arr,2)
    
    f = arr(i);
    try
         rmdir(strcat(currentFolder,'\Data\results'),'s');
    catch ex 
    end

%     movefile(strcat(currentFolder,'\Data\results-',num2str(f)), strcat(currentFolder,'\Data\results'));
    try
        rmdir(strcat(currentFolder,'\Data\CompareResults'),'s');
    catch ex 
    end
    
    try
        rmdir(strcat(currentFolder,'\Data\results1'),'s');
    catch ex 
    end
    
    try
        rmdir(strcat(currentFolder,'\Data\results2'),'s');
    catch ex 
    end
    
    try
        rmdir(strcat(currentFolder,'\Data\results3'),'s');
    catch ex 
    end
    
    simi = preRegistration(f,method,Thresh);
    logg(strcat('executing for file :',mat2str(f)));
    logg(strcat('Similarities :',mat2str(simi)));
    register(f, method, Thresh);
    Atlas(f, method, Thresh, weighted);
    propagateAtlas(f,Reregister);
    Results(tur, : ) = testResults(f);
    logg(strcat('Results :',mat2str(Results(tur, : ))));
    
    
    tur = tur +1;
    
%     movefile(strcat(currentFolder,'\Data\results'), strcat(currentFolder,'\Data\results-',num2str(f)));
    
end
logg (strcat('Mean :',num2str(mean(Results(:,1)))));
logg (strcat('Std :',num2str(std(Results(:,1)))));
logg('       ----------------------------------------------------------------------------');
Results
end
diary off