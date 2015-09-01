% Yash Patel, 201301134 %
% CSE, IIIT-H %


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

% Declare number of pixels in window. %
PIXELSINWINDOW = window_size_x*window_size_y;

% Compute mean and std using Integral image. %
t_integral = integralImage(im_template);
t_mean = (t_integral(window_size_x + 1, window_size_y + 1) - t_integral(window_size_x + 1,1) - t_integral(1,window_size_y + 1) + t_integral(1,1))/PIXELSINWINDOW;
t_std_integral = integralImage(im_template.^2);
t_window = im_template - t_mean;
t_std = sqrt(((t_std_integral(window_size_x + 1, window_size_y + 1) - t_std_integral(window_size_x + 1,1) - t_std_integral(1,window_size_y+1) + t_std_integral(1,1))/PIXELSINWINDOW)-(t_mean*t_mean));

% Compute and store the integral of whole image. %
im_integral = integralImage(im);
im_std_integral = integralImage(im.^2);

% Initialize matrix to hold hold window differences. %
window_sum(1:size(im,1),1:size(im,2)) = 0;

% Iterate over the screen image and compute difference for each window. %
for i=starting_x : starting_x+10
    for j=starting_y : starting_y+10
        
        % Make a window from screen image. %
        starting_x_index = i - window_size_x_half;
        ending_x_index = starting_x_index + window_size_x - 1;
        starting_y_index = j - window_size_y_half;
        ending_y_index = starting_y_index + window_size_y - 1;
        temp_window = double(im(starting_x_index : ending_x_index, starting_y_index : ending_y_index));
        
        % Compute mean, window of operation and standard deviation of
        % window taken. %
        ff_mean = (im_integral(ending_x_index+1,ending_y_index+1) - im_integral(starting_x_index+1,ending_y_index+1) - im_integral(ending_x_index+1,starting_y_index+1) + im_integral(starting_x_index+1, starting_y_index+1))/PIXELSINWINDOW;
        f_mean = mean(temp_window(:));
        f_window = temp_window - f_mean;
        f_std = std(temp_window(:));
        
        % compute ncc. %
        ncc = (f_window.*t_window)/(f_std*t_std);
        ncc = ncc/PIXELSINWINDOW;
        window_sum(i,j) = sum(sum(ncc));
        
    end

end

%coordinates with minimum difference will be the rec thing. %
coordinates = find(window_sum == max(max(window_sum)));
rec_y = (coordinates - (floor(coordinates/size(im,1))*size(im,1))) - window_size_y_half;
rec_x = (floor(coordinates/size(im,1)) + 1) - window_size_x_half;

% Output the whole image and draw rectangle. %
figure, imshow(im)
hold on
rectangle('Position', [rec_x , rec_y, rec_width, rec_height], 'LineWidth', 2);