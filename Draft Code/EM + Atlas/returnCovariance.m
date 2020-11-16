function [Covariance] = returnCovariance(mean,Membership,Image,Nk,classes,dimension)

    for it = 1:classes
        try
        
%         tmp = double(Membership(:,it)).*double(Image);
%         tmp = tmp(tmp>0);
%         
%         if dimension >1
%             chunk  = size(tmp,1)/dimension;
%             t=[];
%             for di=1:dimension
%                 tmp1 = tmp((di-1)*chunk+1:di*chunk);
%                 t=[t tmp1];
%             end
%         else
%             t=tmp;
%         end
        original = double(Image).*double(Membership(:,it));
        tmp = original(Membership(:,it) > 0);
        
    if dimension > 1
        
        for di=2:dimension
            
           original = double(Image(:,di)).*double(Membership(:,it));        
           tmp = [tmp original(Membership(:,it) > 0)];
           
        end
    end
    
        
        Covariance(:,:,it) = zeros(dimension,dimension);
        Covariance(:,:,it) = cov(tmp);
        Covariance(isnan(Covariance))=0;
        catch
           Covariance(:,:,it) = zeros(dimension,dimension); 
        end

end

