function [outputArg1] = niftiwriteB(Img,refPath,destPath)
%UNTITLED4 Summary of this function goes here
%   Detailed explanation goes here
    trtr = load_untouch_nii(refPath);
    trtr.img = single(Img);
    trtr.hdr.dime.datatype=16;
    trtr.hdr.dime.bitpix = 32;
    save_untouch_nii(trtr,destPath)

end

