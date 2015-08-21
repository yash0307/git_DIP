% Yash Patel, 201301134 %
% CSE, IIIT-H %

% Read images, take difference. %
im_1 = imread('spot2-diff1.png');
im_2 = imread('spot2-diff2.png');
im_3 = abs(im_1 - im_2);

im_size = size(im_1);

wow = zeros(im_size(1),im_size(2));

for i=1:im_size(1)
    for j=1:im_size(2)
        if(im_3(i,j) > 10)
            wow(i,j) = 255;
        else
            wow(i,j) =  0;
        end
    end
end
se = strel('disk',5);
out2 = imdilate(wow,se);
imshow(im_1);
[label num]=bwlabel(imfill(out2,'holes'));
props=regionprops(label);
box=reshape([props.BoundingBox],[4 num]);
for cnt=1:num
rectangle('position',box(:,cnt),'edgecolor','r');
end
hold off