classdef EnGP < handle
    %ENGP Summary of this class goes here
    %   Detailed explanation goes here
    
    properties
        props = Properties();
    end
    
    properties (GetAccess = public, SetAccess = private)
        xp
        predict_on
        data = Data();
        model = [];
        process
        fevals = 0;
    end
    
    properties (SetAccess = private)
        prediction_normalised = true;
    end
    
    properties (Dependent)
        hyps
    end
    
    methods
        function self = EnGP()
            
            self.data = Data();
            self.model = [];
            self.process =[];
            
        end
        
        function [hyps] = get.hyps(self)
            hyps = self.process.hyps;
        end
        
        function self = set_hyps(self,hyps)
            self.process.set_hyps(hyps);
            self.props.lims = [ repmat(-2,1,self.process.kernel.nhyp-1) -8; repmat(8,1,self.process.kernel.nhyp-1) 2];
        end
        
        self = set_data(self,x,y,id,normalised,varargin);
        self = set_model(self,model,varargin);
        self = set_process(self,process,xtr,ytr,normalised,varargin);
        self = denormalise_prediction(self);
        self = optimise(self,optmiser);
        
        self = plot(self,x,y);

    end
    
    methods (Static)
        [] = gp_plot(xp,m,v,x,y);
    end
    
end

