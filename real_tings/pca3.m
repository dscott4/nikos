function [scores1, lambda, V] = pca3(data)

[m n] = size(data);
ndata = zeros([m n]);
%{
% Normalise data.

sigmax = std(data);
meanx  = mean(data);
for i = 1:n
   ndata(:,i) = (data(:,i)- meanx(i))/sigmax(i);
end
%}
% SVD.

%covx = cov(ndata(:,1:6));
covx = cov(data);
[U,S,V] = svd(covx);
lambda = diag(S)/sum(diag(S));

% PCA.

%scores = ndata(:,1:6)*V;
scores1 = data*V;

bar(lambda);