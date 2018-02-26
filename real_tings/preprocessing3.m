function [X_test,y_test,X_train,y_train,X_val,y_val,dataset,mu,sigma] = preprocessing3(valRatio,trainRatio)
data_locations = 'Round 3 Data FC.xlsx';
pts = 914;

if nargin < 4
    valRatio =0.9;
    trainRatio = 0.7;
end

[dataset] = load_npower_data(data_locations);
valPts = [round(valRatio*pts):1:pts];
[testPts,trainPts] = create_test_train_indices(round(valRatio*pts),trainRatio);

dataset = dataset(1:pts,:);
[dataset,mu,sigma] = data_normalisation(dataset);
[X_test,y_test] = data_separation(dataset(testPts,:));
[X_train,y_train] = data_separation(dataset(trainPts,:));
[X_val,y_val] = data_separation(dataset(valPts,:));

end