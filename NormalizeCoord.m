function [Y,T] = NormalizeCoord(X)

% Normalize the coordinates
u = mean(X,2);
dist = sqrt(X(1,:).^2 + X(2,:).^2);
meanDist = mean(dist);
scale = sqrt(2)/meanDist;
T = [scale,0,-scale*u(1);
    0,scale,-scale*u(2);
    0,0,1];
Y = T*X;
end