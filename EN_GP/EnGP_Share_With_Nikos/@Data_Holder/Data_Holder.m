classdef Data_Holder < handle
    %DATA_HOLDER Summary of this class goes here
    %   Detailed explanation goes here
    
    properties (SetAccess = private, GetAccess = public)
        inputs = [];
        target = [];
        normalised = false;
    end
    
    methods
        function self = Data_Holder()
            
        end
        
        self = set_data(self,x,y,normalised);
        
    end
    
end

