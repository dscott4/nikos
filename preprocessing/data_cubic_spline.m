data = xlsread('Kept Variables.xlsx','Sheet1');
data = data';
[m,n] = size(data);
x = [1:1:n];
xx = 1:0.1:n;
y = data;
yy = spline(x,y,xx);
plot(x,y,'o',xx,yy)
