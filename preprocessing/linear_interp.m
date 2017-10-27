function [ dataset_large ] = linear_interp( dataset,pts )
%Adds more interpolated points between values (pts = number of points in
%between two values)
dataset = dataset';
[m,n] = size(dataset);
x = [1:1:n];
r = (1/(pts+1));
xx = 1:r:n;
dataset_large = interp1q(x,dataset,xx);
dataset_large = dataset_large';
end