function [ g_min, gx_min, fnum ] = QPSO( gpobj, nvars, size_matrix )

hypnames = fieldnames(gpobj.process.kernel.hyps);

rng('shuffle')

if nargin<4
    lims = [repmat(-2,1,nvars);repmat(6,1,nvars)];
end

intcon = [];


pop = gpobj.props.pop_size;
ngen = 150;
max_stall = 50;
fun_tol = 1e-4;
alpha_lims = [0.5 1.5];
n = 0.5;
u = 0.05;
lims = gpobj.props.lims;

LB = repmat(lims(1,:),pop,1);
UB = repmat(lims(2,:),pop,1);

plt = 0;

p_val = zeros(pop,1);

position = bsxfun(@plus,bsxfun(@times,(lims(2,:)-lims(1,:)),rand(pop,nvars)),lims(1,:));

for i = 1:pop
    p_val(i) = Optimiser.assess_loglike(gpobj,position(i,:),size_matrix,hypnames);
    %p_val(i) = loglike_combined(position(i,:),gpobj.process.inputs,gpobj.process.target,'SEiso');
end

p_best(:,1) = p_val;
p_best(:,2:nvars+1) = position;
[~,I] = min(p_best(:,1));
g_best = p_best(I,:);

buffer = NaN(10,1);
gen = 0;
stall_gen = 0;
new_best = 0;

if plt == 1
    p1 = plot3(position(:,1),position(:,2),p_val,'rx');
    hold on
    b1 = plot3(g_best(2),g_best(3),g_best(1),'gx');
    drawnow
    xlim([-20 20]);
    ylim([-20 20]);
end

fnum = pop;

while gen<ngen
    alpha = (alpha_lims(2)-alpha_lims(1))/(1+exp(u*(gen-n*ngen)))+alpha_lims(1);
    mean_best = mean(p_best,1);
    %alpha = (alpha_lims(2)-alpha_lims(1)).*(ngen-gen)/ngen+alpha_lims(1);
    phi = repmat(rand(pop,1),1,nvars);
    lu = repmat(rand(pop,1),1,nvars);
    attractor = phi.*p_best(:,2:end)+(1-phi).*repmat(g_best(2:end),pop,1);
    if rand()>0.5
        position_test = attractor+alpha.*abs(repmat(mean_best(2:end),pop,1)-position).*log(1./lu);
    else
        position_test = attractor-alpha.*abs(repmat(mean_best(2:end),pop,1)-position).*log(1./lu);
    end
    
    position_test(position_test>UB) = (position(position_test>UB)+UB(position_test>UB))./2;
    position_test(position_test<LB) = (position(position_test<LB)+LB(position_test<LB))./2;
    
    if nargin == 5
        position_test(:,intCon) = round(position_test(:,intCon));
    end
    
    position = position_test;
    
    for i = 1:pop
        p_val(i) = Optimiser.assess_loglike(gpobj,position(i,:),size_matrix,hypnames);
        %p_val(i) = loglike_combined(position(i,:),gpobj.process.inputs,gpobj.process.target,'SEiso');
    end
    
    fnum = fnum+pop;
    
    for i = 1:pop
        if p_val(i)<p_best(i,1)
            p_best(i,1) = p_val(i);
            p_best(i,2:nvars+1) = position(i,:);
        end
        if p_best(i,1)<g_best(1)
            %sprintf('Abs Change = %.3e\n',norm(g_best-p_best(i,:)))
            buffer = circshift(buffer,1);
            buffer(1) = (p_best(i,1)-g_best(1));
            av_change = abs(nanmean(diff(buffer)));
            
            if av_change<fun_tol && gen>5
                fprintf('Tolerance reached (%.6e) after %i generations with %i evaluations\n',av_change,gen,fnum);
                return
            end
            g_best = p_best(i,:);
            new_best = 1;
        end
    end
    
    if plt == 1
        p1.XData = position(:,1);
        p1.YData = position(:,2);
        p1.ZData = p_val;
        b1.XData = g_best(2);
        b1.YData = g_best(3);
        b1.ZData = g_best(1);
        drawnow
        pause(0.1)
    end
    
    if new_best ==1
        stall_gen = 0;
        new_best = 0;
    else
        stall_gen = stall_gen+1;
    end
    
    if stall_gen>max_stall
        disp('Stalled!');
        disp(gen)
        return;
    end
    
    g_min = g_best(1);
    gx_min = g_best(2:end);
    
    fprintf('Best min = %.10e in %i evaluations\n',g_best(1),fnum)
    
    gen = gen+1;
    
end

end
