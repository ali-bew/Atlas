function [output] = gausss(x,means,covs)

try
   output = mvnpdf(x,means,covs); 
catch
    output=0;
end

end

