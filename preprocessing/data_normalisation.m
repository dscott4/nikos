function [ norm_dataset,mu,sigma ] = data_normalisation( dataset )
    mu = mean(dataset,1);
    sigma = std(dataset,1);
    norm_dataset = (dataset-mu)./sigma;
end