function plot_pt_cloud(P)
    % X, Y, and Z should be vectors of the same length
    % C should be in [R G B] format and between values 0 and 1
        X = P(:,1);
        Y = P(:,2);
        Z = P(:,3);
        R = P(:,5);
        G = P(:,6);
        B = P(:,7);
        C = [R G B]./255;
        scatter3(X,Y,Z, 25, C, 'filled');
        view(-170, 4);
        axis([-4 10 -5 5 -10 6]);
end