%% Yash Patel, 201301134 %% 
% Classifying yoga-assanans. %

% Make a global hash table, mapping index to asan name. %
match = containers.Map;
match('1') = 'Ustrasana';
match('2') = 'Veerbhadrasan';
match('3') = 'Vrikhsasana';
match('4') = 'Trikonasana';

% Learn the boundary discriptor. %
boundary_des = containers.Map;
for i=1:4
    
    im = imread(strcat('./yogasan/', num2str(i),'.jpg'));
    im = 255*not(im);
    im = im2bw(im);
    b = bwboundaries(im, 'noholes');
    boundary_des(num2str(i)) = b(1);
    
end

% Using a random function pick and image and classify. %
for j=1:10
    
    random_i = randi([1,4]);
    im = imread(strcat('./yogasan/', num2str(random_i),'.jpg'));
    imshow(im)
    im = 255*not(im);
    im = im2bw(im);
    b = bwboundaries(im, 'noholes');
    for i=1:4
        if(isequal(boundary_des(num2str(i)),b(1)))
            val = strcat('Given asana is ',' : ' ,match(num2str(i)));
            disp(val)
        end
    end
    pause()
    
end