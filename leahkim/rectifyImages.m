function [T1, T2, Pn1, Pn2] = rectifyImages(Po1, Po2)
    % code from 'A compact algorithm for rectification of stereo pairs' Fusiello et al. 2000
    [K1, R1, t1] = extract_params(Po1);
    [K2, R2, t2] = extract_params(Po2);
    
    c1 = -inv(Po1(:,1,:3))*Po1(:,4);
    c2 = -inv(Po2(:,1,:3))*Po2(:,4);
    
    v1 = c1-c2;
    v2 = cross(R1(3,:)', v1);
    v3 = cross(v1, v2);
    R = [v1'/norm(v1)
         v2'/norm(v2)
         v3'/norm(v3)];
    A = (A1 + A2)./2;
    A(1,2)=0
    
    Pn1 = A * [R -R*c1];
    Pn2 = A * [R -R*c2];
    
    T1 = Pn1(1:3, 1:3) * inv(Po1(1:3, 1:3));
    T2 = Pn2(1:3, 1:3) * inv(Po2(1:3, 1:3));
end
