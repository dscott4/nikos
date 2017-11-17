function [fmin, xmin] = SD( gpobj, varargin )

[hyps,size_matrix,hypnames] = Optimiser.unwrap_hyps(gpobj.process.hyps);
x = log(hyps);

tol = 1e-5;
maxiter = 1000;

[f,df] = Optimiser.assess_loglike(gpobj,x,size_matrix,hypnames);

d = -df;
alpha = 0;

for j = 1:maxiter
    
    f_old = f;
    df_old = df;
    
    dd = d*d';
    if dd == 0 % 0 gradient = minimum
        fmin = f_old;
        xmin = alpha;
        return
    end
    
    sd = d./norm(d); % Normalised search
    %sd = d;
    alpha = line_search(@(a) Optimiser.assess_loglike(gpobj,x+a*sd,size_matrix,hypnames),f,tol,100);
    
    [f,df] = Optimiser.assess_loglike(gpobj,x,size_matrix,hypnames);
    
    x = x + alpha*d;
    
end

fmin = f;
xmin = x;



end

function [alpha] = line_search(fitness,f,tol,iters)
    alpha = Optimiser.brent_ls(fitness,0,f,0.1,feval(fitness,1),tol,iters);
end

