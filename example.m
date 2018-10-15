% Example preprocessing of Fourier power bins:

% read in example images
ims = zeros(500, 500, 3, 2);
imdir = 'images';
fbase = fullfile(imdir, 'im_%07d.png');
for iIm = [1,2]
    % load images
    ims(:,:,:,iIm) = imread(sprintf(fbase, iIm));
end

% preprocess colorspace to change to grayscale
[gray_ims, cparams] = preprocColorSpace(ims);
[features, fparams] = preprocFFTbins(gray_ims);