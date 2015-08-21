% Yash Patel, 201301134 %
% CSE, IIIT-H %

% Histrogram equalizarion %


% Read Image. %
im = imread('office.jpg');



% Take size of image and compute number of pixels. %
im_size = size(im);
num_pixels = im_size(1)*im_size(2);


% Initialize frequency arrays for each channel. %
frequency_r = zeros(256, 1);
frequency_g = zeros(256, 1);
frequency_b = zeros(256, 1);
cum_frequency_r = zeros(256, 1);
cum_frequency_g = zeros(256, 1);
cum_frequency_b = zeros(256, 1);


% Initialize probability arrays for each channel. %
prob_r = zeros(256, 1);
prob_g = zeros(256, 1);
prob_b = zeros(256, 1);
cum_prob_r = zeros(256, 1);
cum_prob_g = zeros(256, 1);
cum_prob_b = zeros(256, 1);


% frequency arrays. %
for i=1:im_size(1)
    for j=1:im_size(2)
        r_value = im(i,j,1);
        frequency_r(r_value + 1) = frequency_r(r_value + 1) + 1;
        
        g_value = im(i,j,2);
        frequency_g(g_value + 1) = frequency_g(g_value + 1) + 1;
        
        b_value = im(i,j,3);
        frequency_b(b_value + 1) = frequency_b(b_value + 1) + 1;
        
    end
end

% Find cummulative frequency and probability. %
cum_sum_r = 0;
cum_sum_g = 0;
cum_sum_b = 0;
for i=1:256
    cum_sum_r = cum_sum_r + frequency_r(i);
    cum_frequency_r(i) = cum_sum_r;
   
    cum_sum_g = cum_sum_g + frequency_g(i);
    cum_frequency_g(i) = cum_sum_g;
    
    cum_sum_b = cum_sum_b + frequency_b(i);
    cum_frequency_b(i) = cum_sum_b;
    
end

% Find prob and cum_prob for each channels. %
output_r = zeros(256, 1);
output_g = zeros(256, 1);
output_b = zeros(256, 1);
Quant = 255;

for i=1:256
    prob_r(i) = frequency_r(i)/num_pixels;
    prob_g(i) = frequency_g(i)/num_pixels;
    prob_b(i) = frequency_b(i)/num_pixels;
    
    cum_prob_r(i) = cum_frequency_r(i)/num_pixels;
    cum_prob_g(i) = cum_frequency_g(i)/num_pixels;
    cum_prob_b(i) = cum_frequency_b(i)/num_pixels;
    
    output_r(i) = round(cum_prob_r(i)*Quant);
    output_g(i) = round(cum_prob_g(i)*Quant);   
    output_b(i) = round(cum_prob_b(i)*Quant);
end

% Final Image. %
im_out_r = zeros(im_size(1), im_size(2));
im_out_g = zeros(im_size(1), im_size(2));
im_out_b = zeros(im_size(1), im_size(2));

for i=1:im_size(1)
    for j=1:im_size(2)
        im_out_r(i,j) = output_r(im(i,j,1)+1);
        im_out_g(i,j) = output_g(im(i,j,2)+1);
        im_out_b(i,j) = output_b(im(i,j,3)+1);
    end
end

im_final = uint8(cat(3, im_out_r, im_out_g, im_out_b));
figure, imshow(im)
figure, imshow(im_final)