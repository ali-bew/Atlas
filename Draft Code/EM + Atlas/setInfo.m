function [Oinfo]  = setInfo(Iinfo,Img)

Oinfo=Iinfo;
% Oinfo.Filename = '';
% Oinfo.Filemoddate = '06-Nov-2017 13 =46 =37';
% Oinfo.Filesize = 75235680;
% Oinfo.Version = 'NIfTI1';
% Oinfo.Description = '';
Oinfo.ImageSize = size(Img);
% Oinfo.PixelDimensions = [1 1 1];
Oinfo.Datatype = 'single';
Oinfo.BitsPerPixel = 32;
% Oinfo.SpaceUnits = 'Unknown';
% Oinfo.TimeUnits = 'None';
% Oinfo.AdditiveOffset = 0;
% Oinfo.MultiplicativeScaling = 1;
% Oinfo.TimeOffset = 0;
% Oinfo.SliceCode = 'Unknown';
% Oinfo.FrequencyDimension = 0;
% Oinfo.PhaseDimension = 0;
% Oinfo.SpatialDimension = 0;
% Oinfo.DisplayIntensityRange = [0 0];
% Oinfo.TransformName = 'Sform';
% Oinfo.Transform = [1x1 affine3d];
% Oinfo.Qfactor = -1;
% Oinfo.raw = [1×1 struct];

end

