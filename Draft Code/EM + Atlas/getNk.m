function [Nk] = getNk(Membership,classes)

 [M,I] = max(Membership,[],2);
 
 for it=1:classes
  Nk(it)=sum((I==it),'all');
 end
 
 
end

