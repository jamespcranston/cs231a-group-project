function plotCamerasAndSurf(cameras,voxels)
%PLOTCAMERASANDSURF: show a carve scene, including cameras, images and the model
%
%   PLOTCAMERASANDSURF(CAMERAS,VOXELS) shows the specified list of CAMERAS and the
%   current model as a surface fitted around VOXELS.
%   Copyright 2005-2009 The MathWorks, Inc.
%   $Revision: 1.0 $    $Date: 2006/06/30 00:00:00 $

error( nargchk( 1, 2, nargin ) );

%% Plot each camera centre
set(gca,'DataAspectRatio',[1 1 1])
hold on

N = numel(cameras);
for ii=1:N
    plotCamera(cameras(ii));
end
xlabel('X')
ylabel('Y')
zlabel('Z')


%% And show a surface around the object
if nargin>1 && ~isempty( voxels )
    plotSurface( voxels );
end

%% Light the scene and adjust the view angle to make it a bit easier on 
% the eye
view(3);
grid on;
light('Position',[0 0 1]);
axis tight