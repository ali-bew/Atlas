function [Membership] = returnMembership(alpha,mean,covariance,Image,classes,X1,X2,X3)


for it = 1:classes
   
   t = gausss(Image,mean(:,it)',covariance(:,:,it));

   if it == 1 
    total=t*alpha(it);
   else
    total = total + t*alpha(it);   
   end


end

for it = 1:classes
   
        Membership(:,it) = gausss(Image,mean(:,it)',covariance(:,:,it))*alpha(it)./total;
        Membership(isnan(Membership))=0;
end

%this is the part of adding Atlas
if nargin == 8
    Membership(:,1) = Membership(:,1).*X1;
    Membership(:,2) = Membership(:,2).*X2;
    Membership(:,3) = Membership(:,3).*X3;
    
end
%tmp




[M,I] = max(Membership,[],2);

for it=1:classes
     Membership(:,it)= I==it;  
end 

end

