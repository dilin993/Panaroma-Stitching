function H = computeH(p1,p2)
% find H such that X2 = H*X1 where X1,X2 r p1,p2 in homogenous coord
% p1, p2 should be N point pairs, i.e. p1,p2 should be 2xN matrix N>=4

[Y1,T1] = NormalizeCoord(p1);
[Y2,T2] = NormalizeCoord(p2);

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
% H = H'; % in matlab functions X is Nx2 , so we need to take H'
H = H/H(end,end);
end
    
