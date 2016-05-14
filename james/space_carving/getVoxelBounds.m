function [xlim,ylim,zlim] = getVoxelBounds( frames, useCarving )
%FINDMODEL: Gives a nice bounding box in which the object will be carved
% from. We feed these x/y/z limits into the construction of the inital voxel
% cuboid. 
%
% Arguments:
%          frames - The given data, which stores all the information
%               associated with each frame (P, image, silhouettes, etc.)
%          useCarving - a flag that simply tells us 
%
% Returns:
%          xlim - The limits of the x dimension given as [xmin xmax]
%          ylim - The limits of the y dimension given as [ymin ymax]
%          zlim - The limits of the z dimension given as [zmin zmax]
%
% The current method is to simply use the camera locations as the bounds
% for the 
if nargin < 2
    useCarving = 0;
end

camera_positions = cat( 2, frames.T );
xlim = [min( camera_positions(1,:) ), max( camera_positions(1,:) )];
ylim = [min( camera_positions(2,:) ), max( camera_positions(2,:) )];
zlim = [min( camera_positions(3,:) ), max( camera_positions(3,:) )];

% For the zlim we need to see where each camera is looking. 
range = 0.6 * sqrt( diff( xlim ).^2 + diff( ylim ).^2 );
for ii=1:numel( frames )
    viewpoint = frames(ii).T - range * getCameraDir( frames(ii) );
    zlim(1) = min( zlim(1), viewpoint(3) );
    zlim(2) = max( zlim(2), viewpoint(3) );
end

% Move the limits in a bit since the object must be inside the circle
xrange = diff( xlim );
xlim = xlim + xrange/4*[1 -1];
yrange = diff( ylim );
ylim = ylim + yrange/4*[1 -1];

if useCarving
    %TODO: FILL THIS IN
     % Now perform a rough and ready space-carving to narrow down where it is
    % Use a relatively coarse voxel grid to do it.
    [voxels, voxel_size] = formInitialVoxels( xlim, ylim, zlim, 6000 );
    for ii=1:numel(frames)
        voxels = carve( voxels, frames(ii) );
    end
    
    % Check the limits of where we found data and expand by the resolution
    xlim = [min( voxels(:,1) ),max( voxels(:,1) )] + 2*voxel_size*[-1 1];
    ylim = [min( voxels(:,2) ),max( voxels(:,2) )] + 2*voxel_size*[-1 1];
    zlim = [min( voxels(:,3) ),max( voxels(:,3) )] + 2*voxel_size*[-1 1];
end
