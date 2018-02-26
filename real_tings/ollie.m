SO4new=fillmissing(SO4,'linear');
figure

plot(t,SO4new);
title('Original Data')
xlabel('Year')
ylabel('SO_4^2^- ng/l')
grid on
xlim([1894 2000])
SO42=movmean(SO4new,5);
figure

plot(t,SO42)
title('Seasonal Variations')
xlabel('Year')
ylabel('SO_4^2^- ng/l')
grid on
xlim([1894 2000])
Noise=SO4new-SO42;
figure
plot(t,Noise)
title('Noise')
xlabel('Year')
ylabel('SO_4^2^- ng/l')
grid on
xlim([1894 2000])
figure
histogram(Noise);
title('Distribution of Noise')
ylabel('Number of Occurences')
xlabel('Magnitude of Noise')


