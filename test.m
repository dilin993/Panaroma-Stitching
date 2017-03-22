clear all;
close all;

X1 = [0.5,0.5;0.5,1;1,0.5;1,1];
X1 = [X1,ones(4,1)];
X1 = X1';

H = [9,5,2;...
     11,7,2;...
     1,9,2];
 
X2 = H*X1;
for i=1:4
    X2(:,i) = X2(:,i)/X2(3,i);
end

H1 = computeH(X1,X2);
tform = estimateGeometricTransform(X1(1:2,:)',X2(1:2,:)','projective');
H3 = tform.T;
display(H);
display(H1);
display(H3);