% Takes pairs from the MST and returns rectified images, and associated info.

% TO USE THIS CODE:
% load the 'node_pairs' file from James' folder
% set i to the index of the desired camera pairs
% run the code
% clear all variables except Ps, Ts, offsets, and rectifiedImgs
% type "save('filename')" to save the above values, or concatenate them with
% existing values saved to disk. 

clc; close all;
addpath Davis;
addpath james;
addpath leahkim;

load('../frames.mat');
pairs = node_pairs;

rectifiedImgs = cell(0,2);
offsets = cell(0,2);
Ps = cell(0,2);
Ts = cell(0,2);

i=4


ind1 = pairs(i,1);
ind2 = pairs(i,2);
% Load both cameras and their matrices
cam1 = frames(ind1).P;
cam2 = frames(ind2).P;
im1 = frames(ind1).image;
im2 = frames(ind2).image;
  
% Rectify cameras
[T1, T2, P1, P2] = rectifyImages(cam1, cam2);
Ps = vertcat(Ps, {P1, P2});
Ts = vertcat(Ts, {T1, T2});
disp("Building rectified images");
[o1,m1,s] = buildRectified(im1, T1, true, 0);
[o2,m2] = buildRectified(im2, T2, true, s);
rectifiedImgs = vertcat(rectifiedImgs, {m1, m2});
offsets = vertcat(offsets, {o1, o2});

% Clear unnecessary variables
clear pairs
clear o1
clear o2
clear node_pairs
clear m1
clear m2
clear ind1
clear ind2
clear im1
clear im2
clear i
clear frames
clear cam1
clear cam2
clear T1
clear T2
clear P1
clear P2
