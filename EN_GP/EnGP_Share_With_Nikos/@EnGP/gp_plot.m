function [  ] = gp_plot(xp, m, v, x, y )
%GP_PLOT

p1 = plot(x,y,'r');
hold on
p2 = plot(xp,m(:,1),'b');
lb = m(:,1) - 3*sqrt(v(:,1));
ub = m(:,1) + 3*sqrt(v(:,1));
p3 = plot(xp,lb,'b--');
p4 = plot(xp,ub,'b--');
h = fill([xp',fliplr(xp')],[lb',fliplr(ub')],'b','facealpha',0.25);
title('GP Prediction with Confidence Intervals')
xlabel('X')
ylabel('Y')
legend('True Data','mean','+/- 3\sigma')
%uistack(h,'bottom')
uistack(p4,'top')

if size(m,2)>1
    uistack(h,'top')
    p22 = plot(xp,m(:,2),'Color',[0 0.6 0]);
    lb = m(:,2) - 3*sqrt(v(:,2));
    ub = m(:,2) + 3*sqrt(v(:,2));
    p32 = plot(xp,lb,'LineStyle','--','Color',[0 0.6 0]);
    p42 = plot(xp,ub,'LineStyle','--','Color',[0 0.6 0]);
    h2 = fill([xp',fliplr(xp')],[lb',fliplr(ub')],[0 0.6 0],'facealpha',0.25);
    uistack(p32,'bottom')
    uistack(p22,'bottom')
    uistack(p3,'bottom')
    uistack(p2,'bottom')
    uistack(p1,'bottom')
    legend('True Data','Mean OSA','+/- 3\sigma OSA','Mean MPO','+/- 3\sigma MPO')
    uistack(h2,'bottom')
    uistack(h,'bottom')
    
end

 

end

