% t=Icecoredata21(:,1);
% O=Icecoredata21(:,2);
% SO=Icecoredata21(:,3);
% O=fillmissing(O,'linear');
% SO=fillmissing(SO,'linear');
% figure
% 
% subplot(1,2,1)
% 
% autocorr(O)
% title('Auto-Correlation \delta^1^8O%')
% subplot(1,2,2)
% 
% parcorr(O)
% title('Partial Auto-Correlation \delta^1^8O%')
% figure
% 
% subplot(1,2,1)
% 
% autocorr(SO)
% title('Auto-Correlation SO_4^2^-')
% subplot(1,2,2)
% 
% parcorr(SO)
% title('Partial Auto-Correlation SO_4^2^-')
% logs=log10(SO);
% logs=fillmissing(logs,'linear');
% for i=1:length(logs)
%     if logs(i)<0
%         logs(i)=0.5*(logs(i-1)+logs(i+1));
%     end
% end
% % SOnew=detrend(logs);
% % figure
% % plot(t,logs)
% % xlim([1894 2000])
% % hold on
% % plot(t,SOnew)
% % legend('Log data','Detrended Log data')
% % xlim([1894 2000])
% % xlabel('Year')
% % ylabel('log(SO_4^2^- ng/l)')
% % 
% % figure
% % subplot(1,2,1)
% % 
% % autocorr(SOnew)
% % title('Auto-Correlation De-Trended')
% % subplot(1,2,2)
% % parcorr(SOnew)
% % title('Partial Auto-Correlation De-Trended')
% % r1=0.4783;
% %  SOnewPreW=zeros(length(SOnew)-1,1);
% % for i=2:length(SOnew)
% %     SOnewPreW(i)=((SOnew(i)-r1*SOnew(i-1))/(1-r1));
% % end
% % figure
% % subplot(1,2,1)
% % 
% % autocorr(SOnewPreW)
% % title('Auto-Correlation Pre-Whitened')
% % subplot(1,2,2)
% % 
% % parcorr(SOnewPreW)
% % title('Partial Auto-Correlation Pre-Whitened')
% tautest=horzcat(t,logs);
% [tau, p]=corr(logs(426:1288),t(426:1288));
% % mdlo=fitlm(t,O);
% % mdlso=fitlm(t,SO);
% % figure
% % plot(mdlso)
% % ylabel('SO_4^2^- ng/l')
% % xlabel('Year')
% % xlim([1894 2000])
% mdlO30=fitlm(t(1:632),O(1:632))
% figure
% plot(mdlO30)
% ylabel('\delta^1^8O')
% xlabel('Year')
% % SO42=movmean(logs,250);
% % figure
% % 
% % plot(t,SO42)
% % title('Seasonal Variations')
% % xlabel('Year')
% % ylabel('SO_4^2^- ng/l')
% % grid on
% % xlim([1894 2000])
% 
Z=[0:0.01:20];
constant=2*0.01e-3*1000*1460;
a=100e3*pi/1460;
p=constant*sin(a*(sqrt(100*Z.^2+1)-10*Z));
pfar=constant*sin(a*
plot(Z,p)

