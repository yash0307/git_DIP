% Yash Patel, 201301134 %
% CSE, IIIT-H %


% Read the image %
im = imread('bell.jpg');


% Take input for window size%
prompt = 'WINDOW SIZE INPUT';
window_size = input(prompt)


% Generate averaging/smoothing filter  of window size 3%
filter_averaging = fspecial('average', window_size);


% Apply filter on image to get smoothened image %
im_smoothen = imfilter(im, filter_averaging);


% Take difference of original image with smoothened image %
difference = abs(im - im_smoothen);


% Take K as input from user. %
prompt = 'K INPUT';
k = input(prompt)


% Add the K*difference to original image %
im_highboost_image = im + k*difference;
imshow(im_highboost_image)