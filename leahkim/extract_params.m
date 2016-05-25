function [K, R, t] = extract_params(P)
    Q = inv(P(1:3, 1:3));
    [U,B] = qr(Q);
    
    R = inv(U);
    t = B*P(1:3,4);
    K = inv(B);
    K = K ./K(3,3);
end
