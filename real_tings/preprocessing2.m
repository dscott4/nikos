data_locations = 'Round 1 Data FC.xlsx';
mode = 1;
[dataset] = load_npower_data(data_locations);

if mode == 1
    dataset = dataset(1:731,:);
else
    dataset = dataset(1:500,:);
end

interp_pts = 0; %Set to 0 if no interpolation
%[dataset] = interpolant_creator(dataset,interp_pts,'cubic');

[dataset] = time_series_addition(dataset,1*(interp_pts+1),2012);
[dataset,mu,sigma] = data_normalisation(dataset);

%[ R,cov ] = correlation_covariance(dataset,true);
[X,y] = data_separation(dataset);
%[scores1, lambda, V] = pca3(X);

[dataset] = load_npower_data(data_locations);

if mode == 1
    dataset = dataset(732:end,:);
    [dataset] = time_series_addition(dataset,1*(interp_pts+1),2012);
    [dataset] = data_normalisation_predictors(dataset,mu,sigma);
    [X_pred] = dataset(:,1:(end-1));
else
    dataset = dataset(500:731,:);
    [dataset] = time_series_addition(dataset,1*(interp_pts+1),2012);
    [dataset] = data_normalisation_predictors(dataset,mu,sigma);
    [X_pred] = dataset(:,1:10);
    [y_out] = dataset(:,11);
end

clear data_locations
clear dataset
clear mu
clear sigma
clear mode
clear interp_pts