%% Yash Patel, 201301134. %%
% CSE, IIIT-H %

% Time used is too less !!%

tic
% Read the template and screen image. %
im = imread('vegan-modified.jpg');
im_template = imread('soy-dessert.jpg');

% Use normxcorr2 %
c = normxcorr2(im_template, im);

% take peaks value. %
[y, x] = find(c==max(c(:)));

yoffset = y - size(im_template , 1);
xoffset = x - size(im_template , 2);


hFig = figure;
hAx  = axes;

imshow(im)
imrect(hAx, [xoffset, yoffset, size(im_template, 2), size(im_template, 1)]);
toc