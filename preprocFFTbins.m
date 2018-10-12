function varargout = preprocFFTbins(S, params)
% Usage: [Spreproc, params] = preprocFFTbins(S, params)
% 
% Fourier transform of a stimulus, plus assignment of Fourier magnitude
% into particular spatial frequency bins
%
% Parameters
% ==========
% S : 3D array, (x,y,frames)
%   Stimulus to be preprocessed. Take care of color before coming here,
%   please.
% params : struct array of parameters, with fields:
%   .(see code)
% 
% Returns 
% ======
% Spreproc : Preprocessed stimulus
% params : filled-out param struct
% 
% See also preprocFFT3 for a WIP of doing this w/ 3D Fourier transform (to
% account for motion, too)
% 
% ML 2015.01

dparams.class = 'preprocFFTbins';
dparams.screen_degrees = 21.32;
dparams.angle_bins = [0,180]; %[0,10;90,10]; % max 180
dparams.angle_bin_centers = true; % True = treat columns as center, width; false = columns are min,max
dparams.sfreq_bins = [0,5;5,inf]; % 5 cycles / degree and higher - high freq only
% without this normalization, everything is correlated with everything;
% some images just have more SF contrast than others. These two options go
% some way toward fixing that (the latter (normalize_by_image), set to
% 'zscore', seems best)
dparams.normalize_by_sf = false; 
dparams.normalize_by_image = false; 
dparams.keep_contrast_channel = false;
% Fill in default parameters
if ~exist('params','var')
    params = struct;
end
params = defaultOpt(params,dparams);
[aa,ssff] = ndgrid(params.angle_bins(:,1),params.sfreq_bins(:,1));
params.bin_params = [aa(:),ssff(:)]';
if nargin<1 % just called to set the default set of parameters
	varargout{1} = params;
	return;
end

% For visualization...
make_bin_image = true;

% Helper function for orientation bins
circ_dist = @(a,b,mx) min(abs(a-b),mx-abs(a-b));

% Set up bins in Fourier space
[y,x,N]=size(S);
% Compute pixels per degree for this size image
if ~x==y
    error('Can''t handle non-square images yet!')
end
fx = -x/2:(x/2-1);
fy = -y/2:(y/2-1);
[X,Y] = meshgrid(fx,fy);
[theta,rho]=cart2pol(X,Y);
% Convert rho from cycles per image to cycles per degree
rho = rho/params.screen_degrees;
% Convert theta from radians to degrees
theta=theta/pi*180;
% Mirror top / bottom of image (for symmetrical parts of fft)
theta(theta>0) = 180-theta(theta>0);
% Rotate 90� so 0� corresponds to horizontal orientations in Fourier space
theta = abs(imrotate(theta,90));

% Fourier transform of stimulus
Sf = sqrt(abs(fft2(S)));
% Lame; must be a better way to do this...
for ii = 1:N;
    Sf(:,:,ii) = fftshift(Sf(:,:,ii));
end
% Get DC
centerx = floor(x/2)+1;
centery = floor(y/2)+1;
dc = Sf(centery,centerx,:);
% Mask out DC?
Sf(centery,centerx,:) = nan;
Sf = reshape(Sf,[],N);
if params.normalize_by_image
    switch params.normalize_by_image
        case 'zscore'
            gm = nanmean(Sf,1);
            gs = nanstd(Sf,[],1);
            Sf = bsxfun(@minus,Sf,gm);
            gs(gs==0) = inf; % Avoid /0
            Sf = bsxfun(@rdivide,Sf,gs);
            contrast = gm;
        case 'L2'
            L2 = nansum(Sf.^2,1).^0.5;
            L2n = L2;
            L2n(L2n==0) = inf; % Avoid /0
            Sf = bsxfun(@rdivide,Sf,L2n);
            contrast = L2;
        case 'L1'
            L1 = nanmax(Sf,[],1);
            L1n = L1;
            L1n(L1n==0) = inf; % Avoid /0
            Sf = bsxfun(@rdivide,Sf,L1n);
            contrast = L1;
        case 'demean'
            gm = nanmean(Sf,1);
            Sf = bsxfun(@minus,Sf,gm);
            contrast = gm;
    end
end
% Preallocate Spreproc
Spreproc = zeros(N,size(params.angle_bins,1),size(params.sfreq_bins,1));
% For visualization
if make_bin_image
    bin_image = zeros(size(S,1),size(S,2));
end
ct = 1;
% Loop over orientation / SF bins
for iOri= 1:size(params.angle_bins,1)
    omin = params.angle_bins(iOri,1);
    omax = params.angle_bins(iOri,2);
    if params.angle_bin_centers
        aidx = circ_dist(theta,omin,180)<=omax/2;
    else
        aidx = theta>=omin & theta<omax;
    end
    for iSF=1:size(params.sfreq_bins,1)
        sfmin = params.sfreq_bins(iSF,1);
        sfmax = params.sfreq_bins(iSF,2);
        sfidx = rho >= sfmin & rho < sfmax;
        Idx = aidx & sfidx;
        tmp = Sf(Idx(:),:);
        Spreproc(:,iOri,iSF) = nanmean(tmp,1); %-gm;
        % For display
        if make_bin_image
            bin_image(Idx) = ct;
            ct = ct+1;
        end
    end 
end
% Reshape Spreproc
Spreproc = reshape(Spreproc,N,[]);
if params.normalize_by_sf
    for isf = 1:size(params.sfreq_bins,1)
        sf = params.sfreq_bins(isf,1);
        idx = params.bin_params(2,:)==sf;
        % divide by L2 norm for each spaital frequency
        n = sqrt(sum(Spreproc(:,idx).^2,2));
        Spreproc(:,idx) = bsxfun(@rdivide,Spreproc(:,idx),n);
    end
end
if params.keep_contrast_channel
    Spreproc = [contrast',Spreproc]; % make contrast first channel
end
% Output
varargout{1} = Spreproc;
if nargout>1
    varargout{2} = params;
end
% Done