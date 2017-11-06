function [X,y] = data_separation(data)
    X = data(:,1:(end-1));
    y = data(:,end);
end