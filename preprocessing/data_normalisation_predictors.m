function [ norm_dataset ] = data_normalisation_predictors( dataset,mu,sigma )
    norm_dataset = (dataset-mu)./sigma;
end