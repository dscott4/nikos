function [ dataset_large ] = linear_interp_tom( dataset,pts )

X=dataset;
[m]=length(X);
L = [1:1:m]';
r1 = (1/(pts+1));
L2 = [1:r1:m]';
dataset_large=interp1q(L,X,L2);