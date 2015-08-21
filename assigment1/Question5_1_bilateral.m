% Yash Patel, 201301134 %
% CSE, IIIT-H %


% Read the image %
im = imread('face.png');


% Take user input for sigma %
prompt = 'SIGMA: ';
sigma = input(prompt)


% Make a Gaussian filter of window size 5 %
window_size = 5;
filter_gaussian = fspecial('gaussian', window_size, sigma);


% Generate an empty image of the size of input image %
im_size = size(im);
im_output = uint8(zeros(im_size(1), im_size(2)));


% Iterate over all pixels and apply bilateral filter %
window_half = floor(window_size/2);
for i = 1+window_half:im_size(1) - window_half
    for j = 1+window_half:im_size(2) - window_half
        im_window = double(im(i-window_half:i+window_half, j-window_half:j+window_half));
        % Make filter for this frame %
        filter_frame = [];
        for x1=1:window_size
            for x2=1:window_size
                % Weights %
                val_difference = double(im_window(x1,x2)-im_window(1+window_half, 1+window_half));
                % Exponential values %
                val_exp = (val_difference^2)/((-2)*sigma^2);
                filter_frame(x1,x2) = exp(val_exp)/(sqrt(2*pi)*sigma);
            end
        end
        % Normalization. %
        filter_frame = filter_frame/(min(min(filter_frame)));
        filter_frame = filter_frame/(sum(sum(filter_frame)));
        new_frame = im_window.*filter_frame.*filter_gaussian.*sigma;
        im_output(i,j) = sum(sum(new_frame));
    end
end

% Display input image and output image %
figure, imshow(im)
figure, imshow(im_output)