 function [ fmin, xmin, fnum  ] = CG( gpobj, varargin )
%CG


[hyps,size_matrix,hypnames] = Optimiser.unwrap_hyps(gpobj.process.hyps);
x = log(hyps);

tol = 1e-8;
maxiter = 100;


[f,df] = Optimiser.assess_loglike(gpobj,x,size_matrix,hypnames);
fnum = 1;

d = -df;
alpha = 0;

scheme = 'Dai-Yuan';

xtol = 1e-3;
ftol = 1e-6;


for j = 1:maxiter
    
    x_old = x;
    f_old = f;
    df_old = df;
    
    dd = df_old*df_old';
    if dd < 1e-10 % 0 gradient = minimum
        fmin = f_old;
        xmin = alpha;
        return
    end
    
    sd = d./norm(d);
    [alpha, ls_evals] = line_search(@(a) Optimiser.assess_loglike(gpobj,x+a*sd,size_matrix,hypnames),f,tol,100);
    fnum = fnum+ls_evals;
    
    x = x_old + alpha*sd;
    
    if any(x>gpobj.props.lims(2,:))
        x(x>gpobj.props.lims(2,:)) = (x_old(x>gpobj.props.lims(2,:))+gpobj.props.lims(2,x>gpobj.props.lims(2,:)))/2;
    end
    
    if any(x<gpobj.props.lims(1,:))
        x(x<gpobj.props.lims(1,:)) = (x_old(x<gpobj.props.lims(1,:))+gpobj.props.lims(1,x<gpobj.props.lims(1,:)))/2;
    end
    
    [f,df] = Optimiser.assess_loglike(gpobj,x,size_matrix,hypnames);
    fnum = fnum+1;
    
    
    if (alpha*norm(sd))<xtol && abs(f-f_old)<ftol && j >= 2
        fmin = f;
        xmin = x;
        fprintf('Tolerance reached (%.6e) after %i iterations with %i evaluations\n',abs(f-f_old),j,fnum);
        return
    end
    
    
    y = d-df_old;
    switch scheme
        
        % Reference Hager and Zhang survey of CG methods
        case 'Polark-Ribere'
            beta = (df*y')/norm(df_old)^2;
        case 'Fletcher-Reeves'
            beta = norm(df)^2/norm(df_old)^2;
        case 'Dai-Yuan'
            beta = norm(df)^2/(df*y');
        case 'Hager-Zhang'
            beta = (y'-2*df'*norm(y)^2/(df_old*y'))'*df'/(df_old*y');
    end
    
    
    d = -df + beta*d;
    
    fprintf('Best min = %.10e in %i evaluations\n',f,fnum)
    
    
end

fmin = f;
xmin = x;
fprintf('Max iterations reached: Best min = %.10e\n',f)

end



function [alpha,fnum] = line_search(fitness,f,tol,iters)
[alpha,fmin,fnum] = Optimiser.brent_ls(fitness,0,f,1,feval(fitness,0.1),tol,iters);
end

