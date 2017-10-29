data_locations = 'Round_1_-_Part_1.xlsx';
[dataset] = load_npower_data(data_locations);
interp_pts = 0; %Set to 0 if no interpolation
%[dataset] = interpolant_creator(dataset,interp_pts,'cubic');
[dataset] = time_series_addition(dataset,48*(interp_pts+1),2012);
[dataset,mu,sigma] = data_normalisation(dataset);
%[ R,cov ] = correlation_covariance(dataset,false);
