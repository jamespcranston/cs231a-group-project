function [voxels] = carve( voxels, frame)
% CARVE: carves away voxels that are not inside the silhouette contained in 
%   the view of the camera frame. The resulting voxel array is returned.
% Arguments:
%    voxels - an Nx3 matrix where each row is the location of a cubic voxel
%    frame - The frame we are using to carve the voxels with. Useful data
%       stored in here are the "silhouette" matrix and the
%       projection matrix "P". 
% Returns:
%    voxels - a subset of the argument passed that are inside the
%       silhouette

new_voxels = [];
N = size(voxels,1);
P = frame.P;
s = frame.silhouette;
H = size(s,1);
W = size(s,2);

for i = 1:N
    pt = vertcat(voxels(i,:)',1);
    P_times_pt = P*pt;
    x_img = floor(P_times_pt(1)./P_times_pt(3));
    y_img = floor(P_times_pt(2)./P_times_pt(3));
    
    % if out of bounds
    if x_img < 1 || x_img > W || y_img < 1 || y_img > H
        continue
    end
    
    % keep if projects into the silhouette
    if s(y_img,x_img) == 1
        new_voxels = vertcat(new_voxels, voxels(i,:));
    end
end

voxels = new_voxels;



