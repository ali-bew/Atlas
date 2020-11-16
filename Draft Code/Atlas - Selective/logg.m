function [outputArg1,outputArg2] = logg(s)
t = datetime(now,'ConvertFrom','datenum');

fileID = fopen('C:\Users\developer\Desktop\bew\Courses Girona\Project ISA - MIRA\log.txt','a');
fprintf(fileID,'%s : %s \n',t,s);
fclose(fileID);

end

