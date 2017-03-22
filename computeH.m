function H = computeH(X1,X2)
% X2 = H*X1
[Y1,T1] = NormalizeCoord(X1);
[Y2,T2] = NormalizeCoord(X2);
% Y1 = X1;
% Y2 = X2;
N = size(Y1,2);
A = zeros(2*N,9);

for i=1:N
    A(2*i-1,:) = [-Y1(1,i),-Y1(2,i),-1,0,0,0,...
                Y1(1,i)*Y2(1,i),...
                Y1(2,i)*Y2(1,i),...
                Y2(1,i)];
    A(2*i,:) = [0,0,0,-Y1(1,i),-Y1(2,i),-1,...
                Y1(1,i)*Y2(2,i),...
                Y1(2,i)*Y2(2,i),...
                Y2(2,i)];
end
[~,~,V] = svd(A);
H = V(:,end);
H = reshape(H,3,3);
H = H';
H = T2\H*T1;
H = H';
H = H/H(end,end);
end
    
