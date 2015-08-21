% Yash Patel, 201301134 %
% CSE, IIIT-H %

% Take input from images %
im1 = imread('spot2-diff1.png');
im2 = imread('spot2-diff2.png');

% Take difference of two images %
im_diff = im1 - im2;

% Convert this difference image to gray scale image %
im_difference_gray = rgb2gray(im_diff);

% Threshold=14, based on observations %
th_indexes = find(im_difference_gray > 14);

% Iterage over there indexes to find corresponding mapping in image indexes, find corners of the rectangle to be drawn %
image_size = size(im1);
th_size = size(th_indexes);
for i=1:th_size
    x = th_indexes(i) - (floor(th_indexes(i)/image_size(1))*image_size(1));
    y = floor(th_indexes(i)/image_size(1)) + 1;
    im1(x,y,:) = [0,0,0];
    im2(x,y,:) = [0,0,0];
end
figure, imshow(im1)
figure, imshow(im2)