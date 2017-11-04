[dataset,features] = load_npower_data('NPower\Round_1_-_Part_1.xlsx','feature_labels.mat',0);
X = [ones(size(dataset,1),1),dataset(:,1:(end-1))];
y = dataset(:,end);
[y_pred] = neural_net(X);

plot(y,'x')
hold on
plot(y_pred,'.')

ylabel('Energy Load')
legend('Actual','Predicted')
%[train,val,test] = dividerand(26254,0.7,0.15,0.15);

e = immse(y,y_pred);

figure
bar(100*(y-y_pred)./(y))
ylabel('Error (%)')
