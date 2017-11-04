function [ testInd,trainInd ] = create_test_train_indices(m,trainRatio)
evens = [2:2:m];
all = [1:1:m];
randNums = randperm(length(evens));
testInd = evens(randNums(1:round((m)*(1-trainRatio))));
trainInd=setdiff(all,testInd);
end

