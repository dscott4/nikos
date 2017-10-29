function [ dataset_large ] = interpolant_creator( dataset,pts,type )
%Adds more interpolated points between values (pts = number of points in
%between two values)
dataset = dataset';
[m,n] = size(dataset);
x = [1:1:n];
r = (1/(pts+1));
xx = 1:r:n;

if strcmp(type,'cubic')
    dataset_large = spline(x,dataset,xx);
elseif strcmp(type,'pchip')
    dataset_large = pchip(x,dataset,xx);
elseif strcmp(type,'linear')
    dataset_large = interp1q(x,dataset,xx);
else
    error('Incorrect Interpolation Type');
end
dataset_large = dataset_large';
end
