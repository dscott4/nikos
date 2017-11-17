function self = set_model_data(self,data,normalised)

x = data.inputs;
y = data.target;

if nargin < 4
    self.normalised = false;
else
    self.normalised = normalised;
end

if size(y,2)~=1
    error('Output data must be dimension one')
end

if size(x,1) ~= size(y,1)
    error('Input and output data must have same number of data points')
end

self.data.inputs = x;
self.data.target = y;

end