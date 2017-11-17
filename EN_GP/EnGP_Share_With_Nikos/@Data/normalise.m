function  self  = normalise( self )
%Normalise data to training data

if isempty(self.train.inputs)
    error('No training data supplied to the model')
end

% if self.normalised == true
%     warning('data already normalised')
%     return
% end

if self.train.normalised == false
    
    self.mx = mean(self.train.inputs);
    self.my = mean(self.train.target);
    self.sdx = std(self.train.inputs);
    self.sdy = std(self.train.target);

    inputs = bsxfun(@rdivide,self.train.inputs,self.sdx);
    target = self.train.target./self.sdy;
    self.train.set_data(inputs,target,true)
    
else
    
    warning('Training data already normalised')
    
end

if ~isempty(self.val.inputs)
    
    if self.val.normalised == false

        if size(self.val.inputs,2) ~= size(self.train.inputs,2)
            error('Input dimensions incompatible in validation set')
        end

        if size(self.val.target,2) ~= 1
            error('Output dimension greater than one in validation set')
        end

        inputs = bsxfun(@rdivide,self.val.inputs,self.sdx);
        target = self.val.target./self.sdy;
        self.val.set_data(inputs,target,true)
        
    else
        warning('Validatation data already normalised');
    end
    
else
    warning('No validation data supplied')
end

if ~isempty(self.test.inputs)
    
    if self.test.normalised == false

        if size(self.test.inputs,2) ~= size(self.train.inputs,2)
            error('Input dimensions incompatible in test set')
        end

        if size(self.test.target,2) ~= 1
            error('Output dimension greater than one in test set')
        end

        inputs = bsxfun(@rdivide,self.test.inputs,self.sdx);
        target = self.test.target./self.sdy;
        self.test.set_data(inputs,target,true)
    
    else 
        warning('Test data already normalised')
        
    end
    
else
    warning('No test data supplied')
end

end