classdef Static < Model
    %STATIC_GP Summary of this class goes here
    %   Detailed explanation goes here
    
    properties (SetAccess = private, GetAccess = public)
        name = 'Static GP';
    end
    
    methods
        function self = Static(data,varargin)
            if nargin > 1
                self.normalised = varargin{1};
            else
                normalised = 0;
            end
            
            self = self.set_model_data(data,self.normalised);
        end

    end
    
end

