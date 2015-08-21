% Yash Patel, 201301134 %
% CSE, IIIT-H %


% Histogram equalization. %
% Map the input intensity image to new values. %
% Contrast-limited adaptive histogram equalization %


% Read image. %
im = imread('chip.jpg');

% Histogram equalization. %
im_1 = histeq(im);

im_2 = imadjust(im);

im_3 =  adapthisteq(im);

im_4 = histeq(im_2);

im_5 = adapthisteq(im_2);

figure, imshow(im)
figure, imshow(im_1)
figure, imshow(im_2)
figure, imshow(im_3)
figure, imshow(im_4)
figure, imshow(im_5)