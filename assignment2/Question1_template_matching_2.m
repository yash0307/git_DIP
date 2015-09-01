% Yash Patel, 201301134 %
% CSE, IIIT-H %

% =====Explanation====%
% No, simple absolute sum of differences didn't work. %
% REASON : The two images have different contrast.    %
% different lighting and exposure conditions, thus normal difference won't work. %

% Read Main image and template image. %
im = imread('vegan-modified.jpg');
im_template = imread('soy-dessert.jpg');

% Resize both image to half to redure computation. %
im = imresize(im, 0.5);
im_template = imresize(im_template, 0.5);

% Convert im_template to double for comparision. %
im_template = double(im_template);

% Compute window size of moving image. %
window_size_x = size(im_template, 1);
window_size_y = size(im_template, 2);
window_size_x_half = floor(window_size_x/2);
window_size_y_half = floor(window_size_y/2);

% Compute Screen size of whole image. %
screen_size_x = size(im,1);
screen_size_y = size(im,2);

% Get starting and ending indexes as per window and screen. %
starting_x = 1 + window_size_x_half;
starting_y = 1 + window_size_y_half;
ending_x = screen_size_x - window_size_x_half;
ending_y = screen_size_y - window_size_y_half;

% Declare rectangle coordinates. % 
rec_x= 0;
rec_y = 0;
rec_width = window_size_x;
rec_height = window_size_y;

% flag to terminate. %
flag = 0;

% Initialize matrix to hold hold window differences. %
window_sum(1:size(im,1),1:size(im,2)) = 2341395;

% Iterate over the screen image and compute difference for each window. %
for i=starting_x : ending_x
    for j=starting_y : ending_y
        
        % Make a window from screen image. %
        temp_window = double(im(i-window_size_x_half : i+window_size_x_half, j-window_size_y_half : j+window_size_y_half));
        
        % Compute absolute difference. %
        abs_diff = abs(temp_window - im_template);
        
        % Check if sum of abs_diff is zero, then mark the coordinates of rectangle. %
        window_sum(i,j) = sum(sum(abs_diff));
               
    end
    if(flag==1)
        break
    end
end

% coordinates with minimum difference will be the rec thing. %
coordinates = find(window_sum == min(min(window_sum)));
rec_y = (coordinates - (floor(coordinates/size(im,1))*size(im,1))) - window_size_y_half;
rec_x = (floor(coordinates/size(im,1)) + 1) - window_size_x_half;

% Output the whole image and draw rectangle. %
figure, imshow(im)
hold on
rectangle('Position', [rec_x , rec_y, rec_width, rec_height], 'LineWidth', 2);