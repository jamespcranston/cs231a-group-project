%% SETUP
clear all; close all; clc;

% Load the data
load('frames.mat');

% Construct sparse adjacency matrix.
N = length(frames);
A = zeros(N,N);
for i = 1:numel(frames)
    for j = 1:numel(frames)
        t_i = frames(i).T;
        t_j = frames(j).T;
        A(i,j) = sqrt( (t_i - t_j)' * (t_i - t_j) );
    end
end

% Get minimum spanning tree.
G = graph(A);
T = minspantree(G);
