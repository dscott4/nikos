classdef Optimiser
    %OPTIMISER Summary of this class goes here
    %   Detailed explanation goes here
    
    properties
        
    end
    
    methods
        function self = Optimiser()
            
        end
    end
    
    methods(Static)
        [nlml,hyps,fnum] = QPSO(self,gpobj,nvars,size_matrix,lims);
        [nlml,hyps,fnum] = CG(self,gpobj,nvars,size_matrix);
        [nlml,hyps,fnum] = SD(self,gpobj,nvars,size_matrix);
        [nlml,hyps] = cg_netlab(self,gpobj,nvara,size_matrix);
        hyps = wrap_hyps(hyps,hyp_size,hypnames);
        [hyps,size_matrix,hypnames] = unwrap_hyps(hyps_struct);
        [f,df] = assess_loglike(gpobj, hyps, size_matrix, hypnames );
        [a,b,c,fa,fb,fc,fnum] = bracket(fitness,a,b,fa,fb);
        [ xmin, fmin, fnum ] = brent_ls( fitness,a, fa, b, fb, tol,max_iter );
    end
    
end

