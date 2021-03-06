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
asArray = table2array(T.Edges(:,1));

% Write the node pairings from the MST to a file

% Delete files if they currently exist
if exist('node-pairs.txt', 'file') == 2
    delete('node-pairs.txt');
end

% File to write vanishing points to
fileID = fopen('node-pairs.txt', 'w');

% Collect N vanishing points
for i = 1:size(asArray,1)
    fprintf(fileID, '%8.4f %8.4f\n', asArray(i,1), asArray(i,2));
end

fclose(fileID);


