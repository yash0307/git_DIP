%% Yash Patel, 201301134
% CSE, IIIT-H


%% Idea-1 : Prunning %
% We can prun down the iterations we are making, using the concept of
% Laplacian pyramid. We keep moving to lower levels of laplacian pyramid,
% at some genuine level we can do template matching and revert back to
% obtain the original image. This way basically we are reducing down our
% iterations to only those pixels where template can possibly be present in
% main image.

%% Idea-2 : Convulation %