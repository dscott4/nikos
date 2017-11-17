classdef Data < handle
    %DATA
    
    properties
        train = Train();
        val = Val();
        test = Test();
        mx = [];
        my = [];
        sdx = [];
        sdy = [];
    end
    
    methods
        function self = Data()
            self.train = Train();
            self.val = Val();
            self.test = Test();
            self.mx = [];
            self.my = [];
            self.sdx = [];
            self.sdy = [];
        end
        
        self = normalise(self);
        [self,data] = denormalise(self,data);
        
        
    end
    
end

