function [ self, data ] = denormalise( self, data )
%DENORMALISE 

if nargin < 2
    
    for set = {'train','val','test'}
        if self.(char(set)).normalised == true
            inputs = bsxfun(@times,self.(char(set)).inputs,self.sdx);
            target = bsxfun(@times,self.(char(set)).target,self.sdy);
            self.(char(set)).set_data(inputs,target,false);      
        end
    end
        
elseif nargout > 1
    
    data.inputs = bsxfun(@times,data.inputs,self.sdx);
    data.target = bsxfun(@times,data.target,self.sdy);
    
end

