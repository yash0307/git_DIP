%% Yash Patel, 201301134 %%
% CSE, IIIT-H %

% Read the foreground image. %
im_f = imread('question3_fg.jpg');
figure, imshow(im_f)

% Read the background image. %
im_b = imread('question3_bg.jpg');
figure, imshow(im_b)

% Set values according to background in foreground image. %
im_f_ext_indexes = (((im_f(:,:,1)>15) & (im_f(:,:,2)<240)) | ((im_f(:,:,1)>200) & (im_f(:,:,2)>200) & (im_f(:,:,3)>200)));

im_f_ext = cat(3,im_f_ext_indexes,im_f_ext_indexes, im_f_ext_indexes);

% Keep original value of only indexes specified rest all zero. %
im_f = uint8(double(im_f).*double(im_f_ext));

% Get size of fg image. %
im_f_size = size(im_f);

% Resize background image, according to fg image. %
im_b = imresize(im_b, [im_f_size(1), im_f_size(2)]);

% find modified bg image. %
im_f_ext = not(im_f_ext);
im_final = uint8(double(im_b).*double(im_f_ext));

% add both images. %
im_final = im_final + im_f;
figure, imshow(im_final)