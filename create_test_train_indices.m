function [ testInd,trainInd ] = create_test_train_indices(m,trainRatio)
evens = [2:2:m];
all = [1:1:m];
randNums = randperm(length(evens));
trainInd = evens(randNums(1:round(length(evens)*trainRatio)));
testInd=setdiff(all,trainInd);
end

