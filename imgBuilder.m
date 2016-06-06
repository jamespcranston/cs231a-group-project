% Takes pairs from the MST and returns rectified images, and associated info.

clc; close all;

load('../frames.mat');
addpath Davis;
addpath james;
addpath leahkim;

% Screen off the backgrounds
numC = 5;
imgs = {20,1};
for i=[1:20]
  img = frames(i).image;
  imgs{i} = screen(img,numC);
end
clear img numC frames i
save -mat 'screenedimgs.mat';

load('../frames.mat');
load('construct-pairs/node-pairs.txt');
pairs = node_pairs;

% Generate rectified images
rectifiedImgs = cell(0,2);
Ss = cell(0,2);
Ps = cell(0,2);
Ts = cell(0,2);

for i=1:19
  figure
  ind1 = pairs(i,1);
  ind2 = pairs(i,2);
  % Load both cameras and their matrices
  cam1 = frames(ind1).P;
  cam2 = frames(ind2).P;
  im1 = imgs{ind1};
  im2 = imgs{ind2};
    
  % Rectify cameras
  [T1, T2, P1, P2] = rectifyImages(cam1, cam2);
  Ps = vertcat(Ps, {P1, P2});
  Ts = vertcat(Ts, {T1, T2});
  disp("Building rectified images");
  [m1,s1] = buildRectified(im1, T1, 0, 0, false);
  [m2,s2] = buildRectified(im2, T2, s1(2,1), s1(1,2), false);
  Ss = vertcat(Ss, {s1, s2});
  rectifiedImgs = vertcat(rectifiedImgs, {m1, m2});
end

% Clear unnecessary variables
clear pairs
clear node_pairs
clear m1 m2
clear ind1 ind2
clear im1 im2
clear i
clear frames
clear cam1 cam2
clear T1 T2
clear P1 P2
clear s1 s2
clear imgs

save -mat 'finalinput.mat';