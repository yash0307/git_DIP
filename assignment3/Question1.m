%% Yash Patel, 201301134 %%
% CSE, IIIT-H %

% Read the image. %
[img map] = imread('octone.gif');

% Convert this to jpg image. %
if ~isempty(map), img = ind2rgb(img, map); end

% Convert image from rgb to hsv %
im = rgb2hsv(img);

% Take hue, saturation and value %
im_hue = round(im(:,:,1)*360);
im_saturation = im(:,:,2);
im_value = im(:,:,3);

% Set min and max hue values for Yellow.%
yellow_min = 57;
yellow_max = 90;

% Get binary image corresponting to yellow range. %
yellow = ((im_hue>yellow_min)&(im_hue<=yellow_max));

% Make corresponding RGB image. %
RGB = zeros(size(im,1), size(im,2), 3);
RGB(:, :, 1) = yellow;
RGB(:, :, 2) = yellow;
RGB(:, :, 3) = 0.3*yellow;