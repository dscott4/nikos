function [X,y] = data_separation(data)
    X = data(:,1:2);
    y = data(:,end);
end