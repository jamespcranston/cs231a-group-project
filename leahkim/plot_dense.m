function plot_dense(Ps)
    % X, Y, and Z should be vectors of the same length
    % C should be in [R G B] format and between values 0 and 1
    figure('units', 'normalized', 'outerposition', [0 0 1 1]);
    X=[];
    Y=[];
    Z=[];
    R=[];
    G=[];
    B=[];
    for i=1:19
        P = Ps{i};
        if size(P,2) ~= 7
            P = P';
        end
        X = vertcat(X,P(:,1));
        Y = vertcat(Y,P(:,2));
        Z = vertcat(Z,P(:,3));
        R = vertcat(R,P(:,5));
        G = vertcat(G,P(:,6));
        B = vertcat(B,P(:,7));
        C = [R G B]./255;
        subplot(ceil(19/4), 4, i);
        scatter3(X,Y,Z, 25, C, 'filled');
        view(-170, 4);
        axis([-4 10 -5 5 -10 6]);
        title(i);
    end
end
