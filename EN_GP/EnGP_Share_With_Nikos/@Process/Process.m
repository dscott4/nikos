classdef Process < handle
    %PROCESS Summary of this class goes here
    %   Detailed explanation goes here
    
    properties
        inputs = []; % Training inputs
        target = []; % Training targets
        kernel
        sl = 1;
        Q = [];
        K = [];
        R = [];
        alpha = [];
        nlml = [];
        mp = []; % Prefictive mean
        vp = []; % Predictive variance
        nmse = []; % Predictive NMSE       
    end
    
    properties (SetAccess=private, GetAccess = public)
        hyps
    end
    
    
    methods
        function self = Process(train_data, kernel)
            
%             if nargin < 2 && isempty(self.kernel)
%                 hyps.sf2 = 20;
%                 hyps.ll = repmat(1,1,size(train_data.inputs,2));
%                 hyps.sn2 = 0.001;
%                 self.kernel = (Kernel('Matern32',hyps,true));
%             else
%                 if ~isa(kernel,'Kernel')
%                     error('Must supply kernel object as second argument');
%                 end                  
%                 self.kernel = kernel;
%             end

            if nargin < 2
                error('Must supply kernel')
            else
                self.kernel = kernel;
            end
            
            self.inputs = train_data.inputs;
            self.target = train_data.target;
            
            self.update();

        end
        
        function self = set_hyps(self,hyps)
            self.hyps = hyps;
            self.kernel = Kernel(self.kernel.type,hyps,self.kernel.ARD,self.kernel.subtype,self.kernel.active_dims);
            self.update();
        end
        
        function hyps = get.hyps(self)
            hyps = self.kernel.hyps;
        end
        
        function set.kernel(self,kern)
            self.kernel = kern;
            self.update();
        end        
        
        self = calc_nmse(self,y);
        self = set_process_data(self,data);
        self = update(self);
       
    end
    
end

