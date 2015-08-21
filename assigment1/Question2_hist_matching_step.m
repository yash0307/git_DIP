% Yash Patel, 201301134 %
% CSE, IIIT-H %


% Read Image. %
im = imread('office.jpg');



% Take size of image and compute number of pixels. %
im_size = size(im);
num_pixels = im_size(1)*im_size(2);


% Take histograms of each channel. %
hist_r = imhist(im(:,:,1));
hist_g = imhist(im(:,:,2));
hist_b = imhist(im(:,:,3));


% Find cummulative histograms. %
sum_r = 0;
sum_g = 0;
sum_b = 0;
cum_hist_r = [];
cum_hist_g = [];
cum_hist_b = [];
for i=1:256
    sum_r = sum_r + hist_r(i);
    cum_hist_r(i) = sum_r;
    
    sum_g = sum_g + hist_g(i);
    cum_hist_g(i) = sum_g;
    
    sum_b = sum_b + hist_b(i);
    cum_hist_b(i) = sum_b;
end

% Normalization. %
cum_hist_r = cum_hist_r/(im_size(1)*im_size(2));
cum_hist_g = cum_hist_g/(im_size(1)*im_size(2));
cum_hist_b = cum_hist_b/(im_size(1)*im_size(2));

% Make step function. %
step_func = [];
for i=1:256
    if(i<=128)
        step_func(i) = 0;
    else
        step_func(i) = (im_size(1)*im_size(2))/156;
    end
end

% Normalize the step function. %
step_func = step_func/(im_size(1)*im_size(2));

% Find cummulative of step function. %
cum_step = [];
sum_step = 0;
for i=1:256
    sum_step = sum_step + step_func(i);
    cum_step(i) = sum_step;
end

map_r = zeros(256,1);
map_g = zeros(256,1);
map_b = zeros(256,1);

for i=1:256
    
    [~, closest_match] = min(abs(cum_step - cum_hist_r(i)));
    map_r(i) = closest_match(1);
    
    [~, closest_match] = min(abs(cum_step - cum_hist_g(i)));
    map_g(i) = closest_match(1);
    
    [~, closest_match] = min(abs(cum_step - cum_hist_b(i)));
    map_b(i) = closest_match(1);
    
end

out_r = zeros(im_size(1), im_size(2));
out_g = zeros(im_size(1), im_size(2));
out_b = zeros(im_size(1), im_size(2));
for i=1:im_size(1)
    for j=1:im_size(2)
        out_r(i,j) = map_r(im(i,j,1)+1);
        out_g(i,j) = map_g(im(i,j,2)+1);
        out_b(i,j) = map_b(im(i,j,3)+1);
    end
    
end
final_image = uint8(cat(3,out_r,out_g,out_b));
figure, imshow(im)
figure, imshow(final_image)