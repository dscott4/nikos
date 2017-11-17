function [ xmin, fmin, fnum ] = brent_ls( fitness,a, fa, b, fb, tol,max_iter )

% REFERENCE Numerical Recipes 3rd Edition

phi = (1+sqrt(5))/2;
cphi = (3-sqrt(5))/2;
delta = 1e-10;
if nargin < 8 
    fnum = 0;
end


[a,b,c,fa,fb,fc,brack_num] = Optimiser.bracket(fitness,a,b,fa,fb);
fnum = fnum+brack_num;

if a>b
    error('Must search a to b');
end

% Set all to current minimum

w = b;
v = b;
x = b;
fw = fb;
fv = fb;
fx = fb;


% Step before last was 0
e = 0;

it = 0;



while it < max_iter
    
    m = (a+c)/2; % Get midpoint
    
    tol1 = tol*abs(x)+delta;
    tol2 = 2*tol1;
    
    if abs(x-m)<=(tol2-0.5*(c-a))
        fmin = fx;
        xmin = x;
        %fprintf('Number of function evaluations = %i\n',fnum);
        return
    end
    
    if abs(e)>tol1 % Fit parabola will never do on step 1
        r = (x-w)*(fx-fv);
        q = (x-v)*(fx-fw);
        p = (x-v)*q-(x-w)*r;
        q = 2*(q-r);
        if q>0, p = -p; end
        q = abs(q);
        etemp = e;
        e = d;
        if abs(p) >= abs(0.5*q*etemp) || p<=q*(a-x) || p>=q*(c-x)
            if x >= m
                e = a-x;
            else
                e = c-x;
            end
            d = cphi*(e);
        else
            d = p/q;
            u = x+d;
            if (u-a)<tol2 || (c-u)< tol2
                d = sign(m-x)*tol1;
            end
        end     
    else    
        if x >= m
            e = a-x;
        else
            e = c-x;
        end
        d = cphi*e;
    end
    
    if abs(d) >= tol1
        u = x+d;
    else
        u = x+sign(d)*tol1; 
    end
    
    fu = feval(fitness,u);
    fnum = fnum+1;
    
    if fu <= fx
        if u >=x
            a = x;
        else
            c = x;
        end
        v = w; w = x; x = u;
        fv = fw; fw = fx; fx = fu;
    else
        if u < x
            a = u;
        else
            c = u;
        end
        if (fu <= fv ||w == x)
            v = w;
            w = u;
            fv = fw;
            fw = fu;
        elseif (fu<=fv || v == x || v == w)
            v = u;
            fv = fu;
        end
    end
    it = it+1;
end


warning('Minimum not found in line search, ran out of iterations')
%fprintf('Number of function evaluations = %i\n',fnum);
fmin = fx;
xmin = x;




end

