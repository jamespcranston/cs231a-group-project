function plot_pt_cloud(X, Y, Z, R, G, B)
    % X, Y, and Z should be vectors of the same length
    % C should be in [R G B] format and between values 0 and 1
    %X = randi(100, 1, 100);
    %Y = randi(100, 1, 100);
    %Z = randi(100, 1, 100);
    %figure('Point Cloud Result');
    C = [R G B]./255;
    scatter3(X,Y,Z, 25, C, 'filled');
end