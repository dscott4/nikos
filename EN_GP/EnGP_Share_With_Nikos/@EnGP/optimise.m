function [ self ] = optimise( self, optimiser )
%OPTMISE

if nargin>1 && ischar(optimiser)
    self.props.optimiser = optimiser;
end

hypnames = fieldnames(self.process.kernel.hyps);
for i = 1:length(hypnames)
    hyps{i} = self.process.kernel.hyps.(hypnames{i});
end

size_matrix(1,:) = cellfun(@(x) size(x,1),hyps,'uni',false);
size_matrix(2,:) = cellfun(@(x) size(x,2),hyps,'uni',false);
size_matrix = cell2mat(size_matrix);

[self.process.nlml , hyps, self.fevals] = Optimiser.(self.props.optimiser)(self,self.process.kernel.nhyp,size_matrix);

hyps = mat2cell(exp(hyps),1,size_matrix(2,:));

for i = 1:length(hypnames)
    hyps_struct.(hypnames{i}) = hyps{i};
end

self.process.set_hyps(hyps_struct);


end

