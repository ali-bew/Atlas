function [distance] = dist(Img,Imgref)
%UNTITLED Summary of this function goes here
%   Detailed explanation goes here
% Img = uint8(Img.*255./max(Img));
% Imgref = uint8(Imgref.*255./max(Imgref));
distance = abs(double(double(Imgref)) - double(Img));

end

