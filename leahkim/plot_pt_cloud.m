function plot_pt_cloud(X, Y, Z, C)
    % X, Y, and Z should be vectors of the same length
    % C should be in [R G B] format
    %X = randi(100, 1, 100);
    %Y = randi(100, 1, 100);
    %Z = randi(100, 1, 100);
    %C = [1 0.7 0.3]
    %figure('Point Cloud Result');
    scatter3(X,Y,Z, 'MarkerFaceColor', C, 'MarkerEdgeColor', C);
end