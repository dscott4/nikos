[dataset] = load_npower_data('Round_1_-_Part_1.xlsx');
dataset = fillmissing(dataset,'linear');
dataset = (dataset-mean(dataset,1))./std(dataset,1);
xlswrite('C:\Users\david\Documents\GitHub\nikos\preprocessing\normalised_data.xlsx',dataset)