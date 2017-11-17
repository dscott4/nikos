classdef Model < handle
    %MODEL Summary of this class goes here
    %   Detailed explanation goes here
    
    properties
        data
        type
        normalised
    end
    
    methods
        function self = Model()
            
        end
        
        self = set_model_data(self,data,varargin);
        
    end
    
end
    
