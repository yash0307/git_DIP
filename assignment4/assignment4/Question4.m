%% Yash Patel, 201301134 %%
% Ripple tranform. %


ax = 10;
ay = 15;
tx = 120;
ty = 150;
im = im2double(rgb2gray((imread('q4_image.jpg'))));
subplot(1,2,1); imshow(im); title('Original Image');
[x, y] = meshgrid(1:size(im,2), 1:size(im,1));
x_new = x + ax*sin(2*pi*y/tx);
y_new = y + ay*sin(2*pi*x/ty);
final = interp2( x, y, im, x_new, y_new, 'linear');    
subplot(1,2,2); imshow(final); title('Image After Ripple');