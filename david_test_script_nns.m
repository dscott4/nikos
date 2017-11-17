
for j = 100
    for i = 1:j
    y_pred(:,:,i) = neural_net_net(15,X,y,X_pred,660.166476607388,259.156869694356,0.8);
    end
    pred = mean(y_pred,3);
    err = mae(pred,Theirs)
end