function [voxels, voxel_size] = formInitialVoxels(xlim,ylim,zlim,N)
%FORMINITIALVOXELS  create a basic grid of voxels ready for carving
% Arguments:
%          xlim - The limits of the x dimension given as [xmin xmax]
%          ylim - The limits of the y dimension given as [ymin ymax]
%          zlim - The limits of the z dimension given as [zmin zmax]
%          N - The approximate number of voxels we desire in our grid
%
% Returns:
%          voxels - the matrix of N'x3 (where N' approximately equals N) of
%               voxel locations
%          voxel_size - the distance between the locations of adjacent voxel 
%               (a voxel is a cube)
%
% Our initial voxels will create a rectangular prism defined by the x,y,z
% limits. Each voxel will be a cube, so you'll have to compute the
% approximate side-length (voxel_size) of these cubes as well as how many
% cubes you need to place in each dimension to get around the desired
% number of voxels (N). The final "voxels" output should be a matrix where
% every row is the location of the center of the voxel.

prod_ranges = range(xlim)*range(ylim)*range(zlim);
voxel_size = ceil(nthroot(N./prod_ranges,3));

x_nvoxels = floor(((range(xlim)-voxel_size)./voxel_size) + 1);
y_nvoxels = floor(((range(ylim)-voxel_size)./voxel_size) + 1);
z_nvoxels = floor(((range(zlim)-voxel_size)./voxel_size) + 1);
N_prime = x_nvoxels*y_nvoxels*z_nvoxels;

voxels = zeros(N_prime,3);
idx = 1;

for x = 1:x_nvoxels
    for y = 1:y_nvoxels
        for z = 1:z_nvoxels
            x_coord = xlim(1) + 0.5.*voxel_size + (x-1).*voxel_size;
            y_coord = ylim(1) + 0.5.*voxel_size + (y-1).*voxel_size;
            z_coord = zlim(1) + 0.5.*voxel_size + (z-1).*voxel_size;
            voxels(idx,:) = [x_coord y_coord z_coord];
            idx = idx + 1;
        end
    end
end

