% Yash Patel, 201301134 %
% CSE, IIIT-H %

% Read the actaul image. %
im = double(imread('son3.gif'));

% Read the three rotated images. %
im_1 = double(imread('son3rot1.gif'));
im_2 = double(imread('son3rot2.gif'));
im_3 = double(imread('son3rot3.gif'));

% Take DFTs of these images. %
dft_o = fft2(im);
dft_o = fftshift(dft_o);

dft_1 = fft2(im_1);
dft_1 = fftshift(dft_1);

dft_2 = fft2(im_2);
dft_2 = fftshift(dft_2);

dft_3 = fft2(im_3);
dft_3 = fftshift(dft_3);

%figure, imshow(mat2gray(abs(log(1 + dft_o)))), title('Original Image')
%figure, imshow(mat2gray(abs(log(1 + dft_1)))), title('Image 1')
%figure, imshow(mat2gray(abs(log(1 + dft_2)))), title('Image 2')
%figure, imshow(mat2gray(abs(log(1 + dft_3)))), title('Image 3')

ln_o = mat2gray(abs(log(1 + dft_o)));
ln_1 = mat2gray(abs(log(1 + dft_1)));
ln_2 = mat2gray(abs(log(1 + dft_2)));
ln_3 = mat2gray(abs(log(1 + dft_3)));

bw_o = im2bw(ln_o, 0.80);
bw_1 = im2bw(ln_1, 0.80);
bw_2 = im2bw(ln_2, 0.80);
bw_3 = im2bw(ln_3, 0.80);

[r1 c1] = find(bw_1 == max(max(bw_1)));
[r2 c2] = find(bw_2 == max(max(bw_2)));
[r3 c3] = find(bw_3 == max(max(bw_3)));

size_1 = size(r1);
size_2 = size(r2);
size_3 = size(r3);

ind_min_r1 = find(r1 == min(r1));
ind_max_r1 = find(r1 == max(r1));

theta_1 = radtodeg(atan((c1(ind_max_r1) - c1(ind_min_r1))/(r1(ind_max_r1) - r1(ind_min_r1))))