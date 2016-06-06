clc; close all;
addpath Davis;
addpath james;
addpath leahkim;

% read the node pairs
fileID = fopen('james/construct-pairs/node-pairs.txt', 'r');

% holds pairs of images as an in-memory array,
% hard-coded for now
% TODO: find a way to do this for an arbitrary size
npairs = 19;
pairs = fscanf(fileID, '%f %f', [npairs, 2]);



