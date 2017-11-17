classdef GPR < Process
    %GPR Summary of this class goes here
    %   Detailed explanation goes here
    
    properties
        
    end
    
    methods
        function self = GPR(train_data,kernel)
            self@Process(train_data,kernel);
        end        
        
        self = predict_y(self,model);
        [nlml, dnlml] = loglike(self);
        
        
    end
    
end

