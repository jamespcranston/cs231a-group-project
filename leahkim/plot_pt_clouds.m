function plot_pt_clouds(Ps)
    % X, Y, and Z should be vectors of the same length
    % C should be in [R G B] format and between values 0 and 1
    figure('units', 'normalized', 'outerposition', [0 0 1 1]);
    order = [1 2 3 4 5 11 6 7 12 8 13 14 9 15 10 16 17 18 19];
    for i=1:size(order,2)
        P = Ps{order(1, i)};
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
        scatter3(X,Y,Z, 25, C, 'filled');
        view(-170, 4);
        axis([-4 10 -5 5 -10 6]);
        
        % ordering 1 2 3 4 5 11 6 7 12 8 13 14 9 15 10 16 17 18 19 closest
        % to furtherest
    end
end
