# Takes pairs from the MST and returns rectified images, and associated info.

# TO USE THIS CODE:
# load the 'node_pairs' file from James' folder
# set i to the index of the desired camera pairs
# run the code
# clear all variables except Ps, Ts, offsets, and rectifiedImgs
# type "save('filename')" to save the above values, or concatenate them with
# existing values saved to disk. 

clc; close all;
addpath Davis;
addpath james;
addpath leahkim;

load('construct-pairs/frames.mat');
pairs = node_pairs;
window_diam = 7;
pixel_thresh = .5;

rectifiedImgs = cell(0,2);
offsets = cell(0,2);
Ps = cell(0,2);
Ts = cell(0,2);

i=1


ind1 = pairs(i,1);
ind2 = pairs(i,2);
# Load both cameras and their matrices
cam1 = frames(ind1).P;
cam2 = frames(ind2).P;
im1 = frames(ind1).image;
im2 = frames(ind2).image;
  
# Rectify cameras
[T1, T2, P1, P2] = rectifyImages(cam1, cam2);
Ps = vertcat(Ps, {P1, P2});
Ts = vertcat(Ts, {T1, T2});
disp("Building rectified images");
[o1,m1] = buildRectified(im1, T1, true);
[o2,m2] = buildRectified(im2, T2, true);
rectifiedImgs = vertcat(rectifiedImgs, {m1, m2});
offsets = vertcat(offsets, {o1, o2});