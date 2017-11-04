X = dataset(:,1:(end-1));

X(:,8) = []; %Comment me out

[m,n] = size(X);
T = dataset(:,end);
rmse = zeros(1,n);
trainRatio = 0.7;
hiddenLayerSize = 10;
figure
for i = 40
    hiddenLayerSize = i;
    rmse(i) = neural_net_rmse_finder(hiddenLayerSize,X,T,trainRatio);
    plot(rmse)
end
