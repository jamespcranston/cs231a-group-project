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
        if i == 1
            title('1 and 2');
        elseif i == 2
            title('2 and 3');
        elseif i == 3
            title('3 and 4');
        elseif i == 4
            title('3 and 11');
        elseif i == 5
            title('4 and 5');
        elseif i == 6
            title('10 and 11');
        elseif i == 7
            title('5 and 6');
        elseif i == 8
            title('5 and 13');
        elseif i == 9
            title('10 and 20');
        elseif i == 10
            title('6 and 7');
        elseif i == 11
            title('12 and 13');
        elseif i == 12
            title('13 and 14');
        elseif i == 13
            title('7 and 8');  
        elseif i == 14
            title('14 and 15');
        elseif i == 15
            title('8 and 9');
        elseif i == 16
            title('15 and 16');
        elseif i == 17
            title('16 and 17');
        elseif i == 18
            title('17 and 18');
        elseif i == 19
            title('18 and 19');
        % ordering 1 2 3 4 5 11 6 7 12 8 13 14 9 15 10 16 17 18 19 closest
        % to furtherest
    end
end
