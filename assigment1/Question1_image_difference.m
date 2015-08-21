% Yash Patel, 201301134 %
% CSE, IIIT-H %

% Take input from images %
im1 = imread('spot1-diff1.jpg');
im2 = imread('spot1-diff2.jpg');

% Take difference of two images %
im_diff = im1 - im2;

% Convert this difference image to gray scale image %
im_difference_gray = rgb2gray(im_diff);

% Threshold=14, based on observations %
th_indexes = find(im_difference_gray > 14);

% Iterage over there indexes to find corresponding mapping in image indexes, find corners of the rectangle to be drawn %
image_size = size(im1);
th_size = size(th_indexes);
min_x = th_indexes(1) - (floor(th_indexes(1)/image_size(1))*image_size(1));
min_y = floor(th_indexes(1)/image_size(1)) + 1;
max_x = th_indexes(th_size(1)) - (floor(th_indexes(th_size(1))/image_size(1))*image_size(1));
max_y = floor(th_indexes(th_size(1))/image_size(1)) + 1;

% Draw rectangle with these four points on im1 and im2 and display %
width = max_x - min_x;
height = max_y - min_y;
rec_coordinates = [min_y min_x height width];
figure, imshow(im1)
hold on
rectangle('Position', rec_coordinates, 'LineWidth', 2);
figure, imshow(im2)
rectangle('Position', rec_coordinates, 'LineWidth', 2);
