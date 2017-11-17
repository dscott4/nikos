function self = set_process_data(self,data)

% if nargin<4
%     self.normalised = 0;
% elseif normalised == true || normalised == false
%     self.normalised = normalised;
% else
%     error('Normalised variable is a boolean indicating if the data is normalised')
% end

if size(data.target,2)~=1
    error('Output data must be dimension one')
end

if size(data.inputs,1) ~= size(data.target,1)
    error('Input and output data must have same number of data points')
end

self.inputs = data.inputs;
self.target = data.target;

end