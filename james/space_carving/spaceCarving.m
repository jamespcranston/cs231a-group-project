%% SETUP
clear all; close all; clc;
addpath(genpath('functions'));

% Load the data
load('frames.mat');

partE = 0; % change to 1 for part E
%% PART A: Generate the silhouette for each image
for c=1:numel(frames)
    if partE
        frames(c).silhouette = frames(c).trueSilhouette;
    else
        frames(c).silhouette = generateSilhouette( frames(c).image );
        im = frames(1).image;
    end
end

% Plot the silhouette to make sure that we did it correctly.
figure();

subplot(1,2,1);
imshow( frames(c).image );
title( 'Image' );
axis off;

subplot(1,2,2);
imshow( frames(c).silhouette );
title( 'Silhouette' );
axis off;
%% PART B: Generate the voxel grid
% Find an estimate of the bounds of the object we are about to carve
num_voxels = 6000000; % decrease number of voxels for easier debugging
[xlim,ylim,zlim] = getVoxelBounds( frames , partE);
voxels = formInitialVoxels( xlim, ylim, zlim, num_voxels);
starting_volume = size(voxels);

% Show the whole scene
% figure();
% plotCamerasAndSurf( frames, voxels );
%% Part C: Test out the first carving
voxels = carve( voxels, frames(1) );

% Show Result
figure();
plotCamerasAndSurf( frames(1), voxels );
title( 'Result after 1 carving' )
%% Part D+E: Result after all carvings (remember to change variable in setup for part E)
for c=1:numel(frames)
    if c < 3
        voxels = carve( voxels, frames(c) );
    end
end

% Show Result
figure();
plotCamerasAndSurf( frames, voxels );
title( 'Result after all carvings' );

% figure();
% plotSurface( voxels );
% title( 'Result after all carvings' );