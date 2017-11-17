function self = set_data(self,x,y,normalised)



if nargin<4
    self.normalised = 0;
elseif normalised == true || normalised == false
    self.normalised = normalised;
else
    error('Normalised variable is a boolean indicating if the data is normalised')
end

if size(y,2)~=1
    error('Output data must be dimension one')
end

if size(x,1) ~= size(y,1)
    error('Input and output data must have same number of data points')
end

self.inputs = x;
self.target = y;

end