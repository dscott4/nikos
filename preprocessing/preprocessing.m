data_locations = ['Round_1_-_Part_1.xlsx'];
[dataset] = load_npower_data(data_locations);
pts = 0;
[dataset] = cubic_spline(dataset,pts);
[dataset] = time_series_addition(dataset,48*(pts+1),1.5);
[dataset,mu,sigma] = data_normalisation(dataset);
[ R,cov ] = correlation_covariance(dataset,false);


