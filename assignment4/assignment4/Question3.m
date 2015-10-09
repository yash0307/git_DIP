%% Yash Patel, 201301134 %%
% CSE, IIIT-H %

% Read the Image. % 
im = im2double(rgb2gray(imread('./yogasan/1.jpg')));

% Add Gaussian noise. %
im_noise = imnoise(im,'gaussian',0,0.1);
im = im + im_noise;
figure;imshow(im);


[cA,cH,cV,cD]=dwt2(im,'haar');
figure, subplot(2,2,1);imshow(cA,[]);title('LL band of image');
subplot(2,2,2);imshow(cH,[]);title('LH band of image');
subplot(2,2,3);imshow(cV,[]);title('HL band of image');
subplot(2,2,4);imshow(cD,[]);title('HH band of image');

%Thresholding
cH = zeros(size(cH));
cV = zeros(size(cV));
cD = zeros(size(cD));

figure;imshow(idwt2(cA,cH,cV,cD,'haar'));