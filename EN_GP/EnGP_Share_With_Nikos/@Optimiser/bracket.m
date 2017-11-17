function [a,b,c,fa,fb,fc,fnum] = bracket(fitness,a,b,fa,fb)

% REFERENCE Numerical Recipes 3rd Edition

% Bracket so that fb<fa and fb<fc a minimum lies between a and c at b

phi = (1+sqrt(5))/2;
delta = 1e-10;
max_step = 10;
if nargin < 6
    fnum = 0;
end


% Search downhill from a to b
if fb > fa
    
    % Minimum between a and b assuming gradient at a is negative!
    c = b;
    fc = fb;
    b = a + (c-a)/phi; % Golden section
    fb = feval(fitness,b);
    fnum = fnum+1;
    
    loops = 0;
    while (fb > fa)
        loops = loops+1;
%         if mod(loops,10) == 0
%             c = b;
%             fc = fb;
%             b = a+0.1*(c-a);
%             fb = feval(fitness,b);
%             fnum = fnum+1;
%         else
            c = b;
            fc = fb;
            b = a + (c-a)/phi;
            fb = feval(fitness,b);
            fnum = fnum+1;
%         end
    end
    
else
    
    % Search for c with GR extrapolation
    c = b+phi*(b-a);
    fc = feval(fitness,c);
    fnum = fnum+1;
    
    while fb > fc
        r = (b-a)*(fb-fc);
        q = (b-c)*(fb-fa);
        u = b-((b-c)*q-(b-a)*r)/(2*sign(q-r)*max((q-r),delta)); % Quadratic extrap
        ulim = b+max_step*(c-b); % Maximum limit of bracket
        
        if ((b-u)*(u-c)>0) % Minimum between b and c
            fu = feval(fitness,u);
            fnum = fnum+1;
            if fu < fc % Min between b and c
                a=b;
                b=u;
                fa=fb;
                fb=fu;
                return;
            elseif fu > fb % Min between a and u
                c = u;
                fc = fu;
                return;
            end
            u = c+phi*(c-b); % Parabolic fit did not work use GR extrap
            fu = feval(fitness,u);
            fnum = fnum+1;
            
        elseif ((c-u)*(u-ulim)>0) % Minimum between c and limit
            fu = feval(fitness,u);
            fnum = fnum+1;
            if fu<fc % Shuffle bracket
                b=c;
                fb = fc;
                c=u;
                fc = fu;
                u=c+phi*(c-b);
                fu = feval(fitness,u);
                fnum = fnum+1;
            end
        elseif ((u-ulim)*(ulim-c)>=0) % U hits limit
            u = ulim;
            fu = feval(fitness,u);
            fnum = fnum+1;
        else % Parabolic fit fails
            u = c+ phi*(c-b);
            fu = feval(fitness,u);
            fnum = fnum+1;
        end
        
        a = b; b=c; c=u;
        fa = fb; fb=fc; fc=fu;
        
    end
end
end