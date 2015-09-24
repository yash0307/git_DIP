%% Yash Patel, 201301134 %%
% CSE, IIIT-H %

% Read circle image. %
im = imread('circles.jpg');

% Convert image to gray scale image. %
im = rgb2gray(im);
im = im2bw(im,0.4);
im_bw_pre = zeros(size(im));
nums = zeros(15,2);
% Vary over suitable radius size and apply top-hat filter. %
for i=3:12
    
    % Take the structuring element as circle. %
    se = strel('disk',i);

    % Apply Top-Hat Filter. %
    im_th = imtophat(im,se);
    
    % Convert to binary image. %
    im_bw = im_th - im_bw_pre;
    
    % Remove salt pepper noise for this. %
    im_bw = medfilt2(im_bw, [5,5]);
    
    % Show this image. %
    figure, imshow(im_bw)
    
    % Save im pre as this im bw for next iteration. %
    im_bw_pre = im_th;
    
    % Count the connected components. %
    [l num] = bwlabel(im_bw);
    
    % Store in array. %
    nums(i-2,1) = i;
    nums(i-2,2) = num;
 
end

% Print nums. %
nums