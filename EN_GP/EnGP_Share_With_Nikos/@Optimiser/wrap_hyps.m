function [hyps] = wrap_hyps(hyps_mat,size_matrix,hypnames)

hyps_mat = mat2cell(hyps_mat,1,size_matrix(2,:));

for i = 1:length(hypnames)
    hyps.(hypnames{i}) = hyps_mat{i};
end

end