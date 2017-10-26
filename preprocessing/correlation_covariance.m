function [ R,covariance ] = correlation_covariance( dataset,visualisation )
R = corrcoef(dataset);
covariance = cov(dataset);
if visualisation == true
    plotmatrix(dataset,dataset);
end
end

