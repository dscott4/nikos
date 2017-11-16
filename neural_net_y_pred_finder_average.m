function [rmse,y_pred_avg] = neural_net_y_pred_finder_average(hiddenLayerSize,X,T,X_pred,trainRatio,runs,y_out,ploton)

for i = 1:runs
[~,y_pred{i}] = neural_net_y_pred_finder(10,X,T,X_pred,0.8);
end

Y_pred = cat(3,y_pred{:});
y_pred_avg = mean(Y_pred,3);

if ploton == 1
    figure
    plot(y_out)
    hold on
    plot(y_pred_avg)
    rmse = immse(y_out,y_pred_avg');
end
end
