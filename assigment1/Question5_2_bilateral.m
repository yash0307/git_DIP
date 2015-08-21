% Yash Patel, 201301134 %
% CSE, IIIT-H %


% Read the image %
im = imread('boy_smiling.jpg');


% Take user input for sigma %
prompt = 'SIGMA: ';
sigma = input(prompt)

% Take Window Size input %
prompt = 'WINDOW SIZE: ';
window_size = input(prompt)


% Make a Gaussian filter of window size 5 %
filter_gaussian = fspecial('gaussian', window_size, sigma);


% Generate an empty image of the size of input image %
im_size = size(im);
im_output_r = uint8(zeros(im_size(1), im_size(2)));
im_output_g = uint8(zeros(im_size(1), im_size(2)));
im_output_b = uint8(zeros(im_size(1), im_size(2)));


% Iterate over all pixels and apply bilateral filter %
window_half = floor(window_size/2);
for i = 1+window_half:im_size(1) - window_half
    for j = 1+window_half:im_size(2) - window_half
        
        % Make frames of all three channel. %
        im_window_r = double(im(i-window_half:i+window_half, j-window_half:j+window_half,1));
        im_window_g = double(im(i-window_half:i+window_half, j-window_half:j+window_half,2));
        im_window_b = double(im(i-window_half:i+window_half, j-window_half:j+window_half,3));
        
        
        % Make filter for this frame for each channel. %
        filter_frame_r = [];
        filter_frame_g = [];
        filter_frame_b = [];
        for x1=1:window_size
            for x2=1:window_size
                % Weights for each channel. %
                val_difference_r = double(im_window_r(x1,x2)-im_window_r(1+window_half, 1+window_half));
                val_difference_g = double(im_window_g(x1,x2)-im_window_g(1+window_half, 1+window_half));
                val_difference_b = double(im_window_b(x1,x2)-im_window_b(1+window_half, 1+window_half));
                
                % Exponential values for each channel. %
                val_exp_r = (val_difference_r^2)/((-2)*sigma^2);
                val_exp_g = (val_difference_g^2)/((-2)*sigma^2);
                val_exp_b = (val_difference_b^2)/((-2)*sigma^2);
                
                % Filter for each channel. %
                filter_frame_r(x1,x2) = exp(val_exp_r)/(sqrt(2*pi)*sigma);
                filter_frame_g(x1,x2) = exp(val_exp_g)/(sqrt(2*pi)*sigma);
                filter_frame_b(x1,x2) = exp(val_exp_b)/(sqrt(2*pi)*sigma);
                
            end
        end
        % Normalization each channel. %
        filter_frame_r = filter_frame_r/(min(min(filter_frame_r)));
        filter_frame_g = filter_frame_g/(min(min(filter_frame_g)));
        filter_frame_b = filter_frame_b/(min(min(filter_frame_b)));
        
        % Normalization. %
        filter_frame_r = filter_frame_r/(sum(sum(filter_frame_r)));
        filter_frame_g = filter_frame_g/(sum(sum(filter_frame_g)));
        filter_frame_b = filter_frame_b/(sum(sum(filter_frame_b)));
        
        % New frames after filter for each channel. %
        new_frame_r = im_window_r.*filter_frame_r.*filter_gaussian.*sigma;
        new_frame_g = im_window_g.*filter_frame_g.*filter_gaussian.*sigma;
        new_frame_b = im_window_b.*filter_frame_b.*filter_gaussian.*sigma;
         
        im_output_r(i,j) = sum(sum(new_frame_r));
        im_output_g(i,j) = sum(sum(new_frame_g));
        im_output_b(i,j) = sum(sum(new_frame_b));
    end
end


% Combine all channels to make final image. %
im_output = cat(3, im_output_r, im_output_g, im_output_b);


% Display input image and output image %
figure, imshow(im)
figure, imshow(im_output)