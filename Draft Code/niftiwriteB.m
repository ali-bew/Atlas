function [outputArg1] = niftiwriteB(Img,refPath,destPath)
%UNTITLED4 Summary of this function goes here
%   Detailed explanation goes here
    trtr = load_untouch_nii(refPath);
    trtr.img = Img;
    save_untouch_nii(trtr,destPath);

end