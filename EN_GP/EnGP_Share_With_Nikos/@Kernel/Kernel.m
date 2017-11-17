classdef Kernel < handle
    %KERNEL Summary of this class goes here
    %   Detailed explanation goes here
    
    properties
        hyps
        nhyp
        type
        subtype ='none';
        ARD = false;
        active_dims = [];
        p = [];
    end
    
    methods
        function self = Kernel(type, hyps, ARD, subtype, active_dims)
            
            if ~ischar(type)
                error('Please specify kernel type as string')
            end
            
            if nargin > 1
                self.hyps = hyps;
            else
                hyps.sf2 = 1;
                hyps.ll = 1;
                hyps.sn2 = 0.1;
            end
            
             self.type = type;
            
            if nargin > 2
                self.ARD = ARD;
            else
                self.ARD = false;
            end 
            
            hypnames = fieldnames(hyps);
            for i = 1:length(hypnames)
                hyps_cell{i} = hyps.(hypnames{i});
            end
            
            size_matrix(1,:) = cellfun(@(x) size(x,1),hyps_cell,'uni',false);
            size_matrix(2,:) = cellfun(@(x) size(x,2),hyps_cell,'uni',false);
            size_matrix = cell2mat(size_matrix);
            
            self.nhyp = sum(size_matrix(2,:));
            
            if nargin>3
                self.subtype = subtype;
            end
            
            if nargin > 4
                self.active_dims = active_dims;
            end
            
        end
        
        
       K = RBF(self,xp,xq,hyps,idiff);  
       K = Matern12(self,xp,xq,hyps,idiff);  
       K = Matern32(self,xp,xq,hyps,idiff); 
       K = Matern52(self,xp,xq,hyps,idiff);  
       K = Linear(self,xp,xq,hyps,idiff);
       K = Polynomial(self,xp,xq,hyps,idiff,degree);  
       K = Independent(self,xp,xq,hyps,idiff);
      
    end
    
    methods (Static)
       
    end
    
end

