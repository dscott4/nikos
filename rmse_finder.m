X = dataset(:,1:(end-1));
T = dataset(:,end);
max_nets = 100;
rmse = zeros(1,max_nets);
trainRatio = 0.7;
figure
for i = 1:max_nets
    hiddenLayerSize = i;
    rmse(i) = neural_net_rmse_finder(hiddenLayerSize,X,T,trainRatio);
    plot(i,rmse(i),'x');
    hold on
end
title('Graph to find optimal network size for 1 Hidden Layer NN')
xlabel('Number of Neurones')
ylabel('RMSE')
