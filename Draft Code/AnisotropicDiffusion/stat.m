function [Mean,Dev] = stat(Img)
%UNTITLED Summary of this function goes here
%   Detailed explanation goes here
% Img = uint8(Img.*255./max(Img));
Mean = sum(sum(double(Img)))/(size(Img,1)*size(Img,2));
Dev = sqrt(sum(sum((double(Img)-Mean).^2))/(size(Img,1)*size(Img,2)));

% Mean = 0;
% Dev = 0;
% N = (size(Img,1)*size(Img,2));
% for i = 1 :size(Img,1)
%     for j = 1:size(Img,2)
%         
%             Mean = Mean + Img(i,j);
%        
%         
%     end
%     
% end
% Mean = Mean/N;
% for k = 1 :size(Img,1)
%     for l = 1:size(Img,2)
%       
%             Dev = Dev + (Img(k,l)-Mean)^2;
%          
%         
%         
%     end
%     
% end
% 
% Dev = sqrt(Dev/N);

end

