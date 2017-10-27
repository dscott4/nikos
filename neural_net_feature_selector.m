X = dataset(:,1:(end-1));

X(:,8) = []; %Comment me out

[m,n] = size(X);
T = dataset(:,end);
rmse = zeros(1,max_nets);
trainRatio = 0.7;
hiddenLayerSize = 10;
figure
for i = 1:n
    X_red = X;
    X_red(:,i) = [];
    rmse(i) = neural_net_rmse_finder(hiddenLayerSize,X_red,T,trainRatio);
end
plot(rmse)