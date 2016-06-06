function plot_pt_clouds(Ps)
    % X, Y, and Z should be vectors of the same length
    % C should be in [R G B] format and between values 0 and 1
    figure('units', 'normalized', 'outerposition', [0 0 1 1]);
    for i=1:size(Ps,2)
        P = Ps{i};
        if size(P,2) ~= 7
            P = P';
        end
        X = P(:,1);
        Y = P(:,2);
        Z = P(:,3);
        R = P(:,5);
        G = P(:,6);
        B = P(:,7);
        C = [R G B]./255;
        subplot(ceil(size(Ps,2)/4), 4, i);
        view(-170, 4);
        axis([-10 10 -4 10 -5 5]);
        scatter3(X,Y,Z, 25, C, 'filled');
    end
end
