function ptch = plotSurface( voxels )
%PLOTSURFACE: draw a surface based on some voxels
%
%   PLOTSURFACE(VOXELS) tries to render the supplied voxel structure as a
%   surface using MATLAB's ISOSURFACE command.
%
%   PTCH = PLOTSURFACE(VOXELS) also returns handles to the patches
%   created.

%   Copyright 2005-2009 The MathWorks, Inc.
%  $Revision: 1.0 $    $Date: 2006/06/30 00:00:00 $

% First grid the data
size(voxels)
res = max(voxels(2,:) - voxels(1,:));
ux = unique(voxels(:,1));
uy = unique(voxels(:,2));
uz = unique(voxels(:,3));

% Expand the model by one step in each direction
ux = [ux(1)-res; ux; ux(end)+res];
uy = [uy(1)-res; uy; uy(end)+res];
uz = [uz(1)-res; uz; uz(end)+res];

% Convert to a grid
[X,Y,Z] = meshgrid( ux, uy, uz );

% Create an empty voxel grid, then fill only those elements in voxels
V = zeros( size( X ) );
N = size(voxels,1);
for ii=1:N
    ix = (ux == voxels(ii,1));
    iy = (uy == voxels(ii,2));
    iz = (uz == voxels(ii,3));
    V(iy,ix,iz) = 1;
end

% Now draw it
ptch = patch( isosurface( X, Y, Z, V, 0.5 ) );
isonormals( X, Y, Z, V, ptch )
set( ptch, 'FaceColor', 'r', 'EdgeColor', 'none' );

set(gca,'DataAspectRatio',[1 1 1]);
xlabel('X');
ylabel('Y');
zlabel('Z');
view(-140,22)
lighting( 'gouraud' )
camlight( 'right' )
axis( 'tight' )
