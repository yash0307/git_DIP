%% Yash Patel, 201301134 %% 
% CSE, IIIT-H %

% Read the world map. %
im = double(imread('map.gif'));

% Take image size. %
im_size = size(im);

% Compute the breadth and length of map. %
breadth = im_size(2)/2;
length = im_size(1)/2;


del=0.1;

% Max and Min variations of breadth possible. %
breadth_min_d = -1;
breadth_max_d = 1;

% Max and Min variations of lengths. %
length_min_d = -pi/(2+del);
length_max_d = pi/(2+del);

% Ranges as per function for breadth. %
breadth_min_r = -1;
breadth_max_r = 1;

% Ranges as per function for length. %
length_min_r = log(tan(-pi/2/(2+del)+pi/4));
length_max_r = log(tan(pi/2/(2+del)+pi/4));


% Number of steps size of breadth. %
breadth_step_o = (breadth_max_d - breadth_min_d)/(breadth*2);

% Number of steps size of length. %
length_step_o = (length_max_d - length_min_d)/(length*2);

% Steps size of breadth in transformed image. %
breadth_step_n = (breadth_max_r - breadth_min_r)/(breadth*2);

% Steps size of length in transformed image. %
length_step_n = (length_max_r - length_min_r)/(length*2);

% Old x and y in image, according to domain parameters. %
[ x_o y_o ] = meshgrid( breadth_min_d + breadth_step_o : breadth_step_o : breadth_max_d...
                     , length_min_d + length_step_o : length_step_o : length_max_d );

% New x and y in image, according to range parameters. %
[ x_n y_n ] =  meshgrid( breadth_min_r + breadth_step_n : breadth_step_n : breadth_max_r...
                     , length_min_r + length_step_n :length_step_n : length_max_r );

% Inerse Transformation of coordinates. %
im_o_x = x_n;
im_o_y = 2*(atan(exp(y_n))-pi/4);

% Interpolate the values from neighbours of corresponding old image pixel %
img_final_2 = interp2 (x_o, y_o, im, im_o_x, im_o_y );

figure;
imshow(img_final_2);
title('Mercartor-projection of World Map');