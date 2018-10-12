function params = preprocFFTbins_GetMetaParams(arg)
% Usage: 

params.class = 'preprocFFTbins';
switch arg
    case 1
        % Hi-lo spatial frequency only
        params.screen_degrees = 21.32;
        params.angle_bins = [0,180]; % Single orientation bin
        params.angle_bin_centers = false; % True = treat columns as center, width; false = columns are min,max
        params.sfreq_bins = [0,5;5,inf]; % above/below 5 cycles / degree 
    case 2
        % Hi-lo spatial frequency, w/ orientation bins
        params.screen_degrees = 21.32;
        params.angle_bins = [0:30:150;30*ones(1,6)]'; % bin centers, widths
        params.angle_bin_centers = true; % True = treat columns as center, width; false = columns are min,max
        params.sfreq_bins = [0,5;5,inf]; % above/below 5 cycles / degree 

    case 3
        % Hi-lo spatial frequency only, w/ not-quite-so-high spat. freq.
        params.screen_degrees = 21.32;
        params.angle_bins = [0,180]; % Single orientation bin
        params.angle_bin_centers = false; % True = treat columns as center, width; false = columns are min,max
        params.sfreq_bins = [0,3;3,inf]; % above/below 3 cycles / degree 
    case 4
        % Hi-lo spatial frequency, w/ orientation bins, w/ not-quite-so-high spat. freq.
        params.screen_degrees = 21.32;
        params.angle_bins = [0:30:150;30*ones(1,6)]'; % bin centers, widths
        params.angle_bin_centers = true; % True = treat columns as center, width; false = columns are min,max
        params.sfreq_bins = [0,3;3,inf]; % above/below 3 cycles / degree 

    case 5
        % Hi-lo spatial frequency, w/ orientation bins, 8 x 45 degree bins
        params.screen_degrees = 21.32;
        params.angle_bins = [0:45:135;45*ones(1,4)]'; % bin centers, widths
        params.angle_bin_centers = true; % True = treat columns as center, width; false = columns are min,max
        params.sfreq_bins = [0,5;5,inf]; % above/below 5 cycles / degree 

    case 6
        % Hi-lo spatial frequency, w/ orientation bins, 8 x 45 degree bins
        params.screen_degrees = 21.32;
        params.angle_bins = [0:22.5:157.5;22.5*ones(1,8)]'; % bin centers, widths
        params.angle_bin_centers = true; % True = treat columns as center, width; false = columns are min,max
        params.sfreq_bins = [0,5;5,inf]; % above/below 5 cycles / degree 

    %%% --- Same as 1-6, but with normalization by SF (when applicable) --- %%% 
    case 7
        % Hi-lo spatial frequency, w/ orientation bins, 6 * 30 degree bins
        params.screen_degrees = 21.32;
        params.angle_bins = [0:30:150;30*ones(1,6)]'; % bin centers, widths
        params.angle_bin_centers = true; % True = treat columns as center, width; false = columns are min,max
        params.sfreq_bins = [0,5;5,inf]; % above/below 5 cycles / degree 
        params.normalize_by_sf = true;
    case 8
        % Hi-lo spatial frequency, w/ orientation bins, w/ not-quite-so-high spat. freq.
        params.screen_degrees = 21.32;
        params.angle_bins = [0:30:150;30*ones(1,6)]'; % bin centers, widths
        params.angle_bin_centers = true; % True = treat columns as center, width; false = columns are min,max
        params.sfreq_bins = [0,3;3,inf]; % above/below 3 cycles / degree 
        params.normalize_by_sf = true;
    case 9
        % Hi-lo spatial frequency, w/ orientation bins, 4 x 45 degree bins
        params.screen_degrees = 21.32;
        params.angle_bins = [0:45:135;45*ones(1,4)]'; % bin centers, widths
        params.angle_bin_centers = true; % True = treat columns as center, width; false = columns are min,max
        params.sfreq_bins = [0,5;5,inf]; % above/below 5 cycles / degree 
        params.normalize_by_sf = true;
    case 10
        % Hi-lo spatial frequency, w/ orientation bins, 8 x 22.5 degree bins
        params.screen_degrees = 21.32;
        params.angle_bins = [0:22.5:157.5;22.5*ones(1,8)]'; % bin centers, widths
        params.angle_bin_centers = true; % True = treat columns as center, width; false = columns are min,max
        params.sfreq_bins = [0,5;5,inf]; % above/below 5 cycles / degree         
        params.normalize_by_sf = true;
    %%% --- Same as 7-10, but with zscore normalization by image (when applicable) --- %%% 
    case 11
        % Hi-lo spatial frequency, w/ orientation bins, 6 * 30 degree bins
        params.screen_degrees = 21.32;
        params.angle_bins = [0:30:150;30*ones(1,6)]'; % bin centers, widths
        params.angle_bin_centers = true; % True = treat columns as center, width; false = columns are min,max
        params.sfreq_bins = [0,5;5,inf]; % above/below 5 cycles / degree 
        params.normalize_by_sf = false;
        params.normalize_by_image = 'zscore';
    case 12
        % Hi-lo spatial frequency, w/ orientation bins, w/ not-quite-so-high spat. freq.
        params.screen_degrees = 21.32;
        params.angle_bins = [0:30:150;30*ones(1,6)]'; % bin centers, widths
        params.angle_bin_centers = true; % True = treat columns as center, width; false = columns are min,max
        params.sfreq_bins = [0,3;3,inf]; % above/below 3 cycles / degree 
        params.normalize_by_sf = false;
        params.normalize_by_image = 'zscore';
    case 13
        % Hi-lo spatial frequency, w/ orientation bins, 4 x 45 degree bins
        params.screen_degrees = 21.32;
        params.angle_bins = [0:45:135;45*ones(1,4)]'; % bin centers, widths
        params.angle_bin_centers = true; % True = treat columns as center, width; false = columns are min,max
        params.sfreq_bins = [0,5;5,inf]; % above/below 5 cycles / degree 
        params.normalize_by_sf = false;
        params.normalize_by_image = 'zscore';
    case 14
        % Hi-lo spatial frequency, w/ orientation bins, 8 x 22.5 degree bins
        params.screen_degrees = 21.32;
        params.angle_bins = [0:22.5:157.5;22.5*ones(1,8)]'; % bin centers, widths
        params.angle_bin_centers = true; % True = treat columns as center, width; false = columns are min,max
        params.sfreq_bins = [0,5;5,inf]; % above/below 5 cycles / degree         
        params.normalize_by_sf = false;
        params.normalize_by_image = 'zscore';
    
    %%% --- Same as 7-10, but with L2 normalization by image (when applicable) --- %%% 
    case 15
        % Hi-lo spatial frequency, w/ orientation bins, 6 * 30 degree bins
        params.screen_degrees = 21.32;
        params.angle_bins = [0:30:150;30*ones(1,6)]'; % bin centers, widths
        params.angle_bin_centers = true; % True = treat columns as center, width; false = columns are min,max
        params.sfreq_bins = [0,5;5,inf]; % above/below 5 cycles / degree 
        params.normalize_by_sf = false;
        params.normalize_by_image = 'L2';
    case 16
        % Hi-lo spatial frequency, w/ orientation bins, w/ not-quite-so-high spat. freq.
        params.screen_degrees = 21.32;
        params.angle_bins = [0:30:150;30*ones(1,6)]'; % bin centers, widths
        params.angle_bin_centers = true; % True = treat columns as center, width; false = columns are min,max
        params.sfreq_bins = [0,3;3,inf]; % above/below 3 cycles / degree 
        params.normalize_by_sf = false;
        params.normalize_by_image = 'L2';
    case 17
        % Hi-lo spatial frequency, w/ orientation bins, 4 x 45 degree bins
        params.screen_degrees = 21.32;
        params.angle_bins = [0:45:135;45*ones(1,4)]'; % bin centers, widths
        params.angle_bin_centers = true; % True = treat columns as center, width; false = columns are min,max
        params.sfreq_bins = [0,5;5,inf]; % above/below 5 cycles / degree 
        params.normalize_by_sf = false;
        params.normalize_by_image = 'L2';
    case 18
        % Hi-lo spatial frequency, w/ orientation bins, 8 x 22.5 degree bins
        params.screen_degrees = 21.32;
        params.angle_bins = [0:22.5:157.5;22.5*ones(1,8)]'; % bin centers, widths
        params.angle_bin_centers = true; % True = treat columns as center, width; false = columns are min,max
        params.sfreq_bins = [0,5;5,inf]; % above/below 5 cycles / degree         
        params.normalize_by_sf = false;
        params.normalize_by_image = 'L2';
%%% --- Same as 17, but keeping contrast channel --- %%%
    case 19
        % Hi-lo spatial frequency, w/ orientation bins, 4 x 45 degree bins
        params.screen_degrees = 21.32;
        params.angle_bins = [0:45:135;45*ones(1,4)]'; % bin centers, widths
        params.angle_bin_centers = true; % True = treat columns as center, width; false = columns are min,max
        params.sfreq_bins = [0,5;5,inf]; % above/below 5 cycles / degree 
        params.normalize_by_sf = false;
        params.normalize_by_image = 'L2';
        params.keep_contrast_channel = true;
end

