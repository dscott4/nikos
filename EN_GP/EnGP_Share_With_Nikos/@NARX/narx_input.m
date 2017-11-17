function [ inputs,offset ] = narx_input(self,data)

% Function to assemble input matrix for NARX models from a multidimensional
% input, x, and one dimensioned output, y, with lag multipliers, self.xoff and
% self.yoff.
%
% x     - input matrix with each dimension being a column vector
% y     - column vector output
% self.xlags - number of lags on the input
% self.ylags - number of lags on the output
% self.xoff  - input lag multiplier
% self.yoff  - output lag multiplier
%


x = data.inputs;
y = data.target;



% Check that column vectors of inputs if not transpose 
if size(x,1)<size(x,2); x = x'; end
if size(y,1)<size(y,2); y = y'; end

% Input handling for back compatibility if no offsets supplied
if nargin < 5
    self.xoff = 1;
    self.yoff = 1;
elseif nargin < 6
    self.yoff = self.xoff;
end


self.ninput = self.xlags*self.nx+self.ylags; %Number of dimensions in NARX input vector

% Set NARX indices
xind = 1:self.xoff:self.xlags*self.xoff;
yind = 1:self.yoff:self.ylags*self.yoff;
offset = max([xind, yind]);
npts = size(x,1)-offset;

% Preallocate
inputs = zeros(npts,self.ninput);

% Assign output lags
for i = 1:self.ylags
    yi = yind(i);
    inputs(:,i) = y(offset+1-yi:length(x)-yi);
end

% Assign input lags
for i = 1:self.xlags
    for variable = 1:self.nx
        xi = xind(i);
        inputs(:,i+(variable-1)*self.xlags+self.ylags) = x(offset+2-xi:length(x)-xi+1,variable);
    end
end

end

