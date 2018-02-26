[X_test,y_test,X_train,y_train,X_val,y_val,dataset,mu,sigma,trainInd,testInd,valInd] = preprocessing3();
theta = regress([y_train;y_val],[ones(length(X_train),1),X_train;ones(length(X_val),1),X_val]);
y_pred = [ones(length(X_test),1),X_test]*theta;
err = immse(y_pred,y_test);

plot([trainInd,valInd],[y_train;y_val],'.')
hold on
plot(testInd,y_test,'.')
hold on
plot(testInd,y_pred)
legend('Training Data','Test Data','Linear Regression')