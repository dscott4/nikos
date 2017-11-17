function self = set_model(self,model,varargin)

model_build = model;

if ~isempty(self.data.train.inputs)
    
    self.model = model_build(self.data.train,varargin);
    if ~isempty(self.process)
        if self.process.kernel.ARD == true && self.process.kernel.nhyp ~= 2+size(self.model.data.inputs,2)
            hyps = self.process.hyps;
            hyps.ll = repmat(5,1,size(self.model.data.inputs,2));
            self.process.set_hyps(hyps);
        end
        self.process.set_process_data(self.model.data);
        
    else
        warning('No Process Specified, setting to full GPR')
        
        %self.set_process(@GPR);
    end
        
else
    
    error('Cannot set model no training data present.')
    
end

end