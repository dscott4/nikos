function [X_test,y_test,X_train,y_train,X_val,y_val,dataset,mu,sigma,trainInd,testInd,valInd] = preprocessing3(testRatio,trainRatio)
data_locations = 'Round 3 Data FC.xlsx';
pts = 914;

if nargin < 4
    testRatio =0.9;
    trainRatio = 0.7;
end
trainRatio = trainRatio/testRatio;

[dataset] = load_npower_data(data_locations);
testInd = [round(testRatio*pts):1:pts];
[valInd,trainInd] = create_test_train_indices(round(testRatio*pts)-1,trainRatio);

dataset = dataset(1:pts,:);
[dataset,mu,sigma] = data_normalisation(dataset);
[X_test,y_test] = data_separation(dataset(testInd,:));
[X_train,y_train] = data_separation(dataset(trainInd,:));
[X_val,y_val] = data_separation(dataset(valInd,:));
end