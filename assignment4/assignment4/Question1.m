%% Yash Patel, 201301134 %%

% Find the imperfect bottle. %

% Read the image. %
im = imread('bottles.tif');

% Convert this image to binary image. %
im_bw = im2bw(im, 0.8);

% Iteratively find the connected components. %
for i=1:5
    
    % Find the connected components. %
    im_cc = bwconncomp(im_bw);
    
    % Find the largest connected comp. in the image. %
    numPixels = cellfun(@numel,im_cc.PixelIdxList);
    [biggest,idx] = max(numPixels);
    
    
    % Make image, negation of conncomp. %
    im_cnn = zeros(size(im_bw));
    
    % Make the conn comp pixels of this as one. %
    im_cnn(im_cc.PixelIdxList{idx}) = 255;
    
    % Convert this to binary image and show. %
    im_cnn_bw = im2bw(im_cnn, 0.5);
    
    % Find the num of pixels in given conn components. %
    a = find(im_cnn_bw);
    if size(a,1) > 5000
        val = 'Given bottle is not correctly filled.';
        disp(val)
        figure, imshow(im_cnn_bw), title(val)
        pause();
    else
        val = 'Given bottle is correctly filled.';
        disp(val)
        figure, imshow(im_cnn_bw), title(val)
        pause();
    end
    
    % Change the given image by removing the largest cnncomp. %
    im_bw(im_cc.PixelIdxList{idx}) = 0;
    
end