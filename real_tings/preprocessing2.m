data_locations = 'Round 1 Data FC.xlsx';
[dataset] = load_npower_data(data_locations);
dataset = dataset(1:731,:);
interp_pts = 0; %Set to 0 if no interpolation
%[dataset] = interpolant_creator(dataset,interp_pts,'cubic');
[dataset] = time_series_addition(dataset,1*(interp_pts+1),2012);
%[dataset,mu,sigma] = data_normalisation(dataset);
%[ R,cov ] = correlation_covariance(dataset,false);
