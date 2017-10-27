X = dataset(:,1:(end-1));
T = dataset(:,end);
max_nets = 4;
rmse = zeros(1,max_nets);
trainRatio = 0.7;
figure
for i = 1:max_nets
    hiddenLayerSize = i;
    rmse(i) = neural_net_rmse_finder(hiddenLayerSize,X,T,trainRatio);
end
plot(rmse);