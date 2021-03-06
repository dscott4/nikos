data_locations = 'Round 3 Data FC.xlsx';

mode = 'test';

mode = 'final';
[dataset] = load_npower_data(data_locations);

if strcmp(mode,'final')
    pts = 1096;
    dataset = dataset(1:pts,:);
    [dataset,mu,sigma] = data_normalisation(dataset);
    [X,y] = data_separation(dataset);
    [dataset] = load_npower_data(data_locations);
    X_pred = dataset((pts+1):end,1:9);
    [X_pred] = data_normalisation_predictors(X_pred,mu(:,1:(end-1)),sigma(:,1:(end-1)));
elseif strcmp(mode,'test')
    pts1 = 914;
    pts2 = 1096;
    dataset = dataset(1:pts1,:);
    [dataset,mu,sigma] = data_normalisation(dataset);
    [X,y] = data_separation(dataset);
    [dataset] = load_npower_data(data_locations);
    dataset = dataset((pts1+1):pts2,:);
    [dataset] = data_normalisation_predictors(dataset,mu,sigma);
    [X_pred,Y_out] = data_separation(dataset);
end




%[dataset] = load_npower_data(data_locations);
%{
if mode == 1
    dataset = dataset(1:pts,:);
else
    dataset = dataset(1:500,:);
end

interp_pts = 0; %Set to 0 if no interpolation
%[dataset] = interpolant_creator(dataset,interp_pts,'cubic');

%[dataset] = time_series_addition(dataset,1*(interp_pts+1),2012);
[dataset,mu,sigma] = data_normalisation(dataset);

%[ R,cov ] = correlation_covariance(dataset,true);
[X,y] = data_separation(dataset);
%[scores1, lambda, V] = pca3(X);

[dataset] = load_npower_data(data_locations);

if mode == 1
    dataset = dataset((pts+1):end,:);
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

%}
clear data_locations
clear dataset
clear mode
clear interp_pts