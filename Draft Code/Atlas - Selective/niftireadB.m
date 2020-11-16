function [outputArg1] = niftireadB(filename)
%UNTITLED3 Summary of this function goes here
%   Detailed explanation goes here
    trtr = load_untouch_nii(filename);
    outputArg1 = trtr.img;
   
end

