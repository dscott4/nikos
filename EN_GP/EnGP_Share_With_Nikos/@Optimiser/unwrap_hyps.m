function [ hyps, size_matrix, hypnames ] = unwrap_hyps( hyp_struct )
%UNWRAP_HYPS 

hypnames = fieldnames(hyp_struct);
for i = 1:length(hypnames)
    hyps{i} = hyp_struct.(hypnames{i});
end

size_matrix(1,:) = cellfun(@(x) size(x,1),hyps,'uni',false);
size_matrix(2,:) = cellfun(@(x) size(x,2),hyps,'uni',false);
size_matrix = cell2mat(size_matrix);

hyps = cell2mat(hyps);

end

