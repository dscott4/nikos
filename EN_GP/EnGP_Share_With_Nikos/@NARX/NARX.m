classdef NARX < Model
    %NARX Summary of this class goes here
    %   Detailed explanation goes here
    
    
    properties (SetAccess = private, GetAccess = public)
        name = 'NARX';
        xoff
        yoff
        xlags
        ylags
        nx
        ninput
        offset
        np
    end
    
    methods
        function self = NARX( data,lag_data,varargin )
            
            if nargin < 2
                error('Must supply data and lag information to the NARX model')
            end
%             
%             if nargin <3
%                 self.normalised = false;
%             else
%                 self.normalised = varargin{1};
%             end
            
            self.xlags = lag_data{1};
            self.ylags = lag_data{2};
            self.xoff = lag_data{3};
            self.yoff = lag_data{4};
            
            self.nx = size(data.inputs,2);
            
            
            
            [self.data.inputs,self.offset] = self.narx_input(self,data);
            self.data.target = data.target(self.offset+1:end,1);
            
            self.np = length(self.data.target);
            
        end
        
    end
    
    methods (Static)
        [inputs,offset] = narx_input(self,data);
    end
    
end

