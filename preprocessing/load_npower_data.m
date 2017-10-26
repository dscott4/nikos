function [dataset] = load_npower_data(data_location)
%Loads data from spreadsheets - need to update to cocatenate new
%spreadsheets
dataset = xlsread(data_location);
dataset = fillmissing(dataset,'linear');
end