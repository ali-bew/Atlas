function [mean] = returnMean(Membership,Image,Nk,classes)

    for it = 1:classes 

      mean(:,it) = sum(double(Membership(:,it)).*double(Image))/Nk(it);
    end
    mean(isnan(mean))=0;

end

