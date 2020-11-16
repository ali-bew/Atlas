function [alpha] = returnAlpha(Membership,classes)
Nk=getNk(Membership,classes);
N=size(Membership,1);
alpha=Nk/N;
alpha(isnan(alpha))=0;
end

