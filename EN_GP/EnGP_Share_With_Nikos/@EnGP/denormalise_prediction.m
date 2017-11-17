function [ self ] = denormalise_prediction( self )
%DENORMALISE_PREDICTION 

if self.data.train.normalised == true && self.prediction_normalised == true
    
    if ~isa(self.model,'NARX')
        p.inputs = self.xp;
        p.target = self.process.mp;
        [~,p] = self.data.denormalise(p);
        
        self.xp = p.inputs;
        self.process.mp = p.target;
        
        self.process.vp = self.data.sdy^2.*self.process.vp;
        
        self.prediction_normalised = false;
    else
        
        p.inputs = self.xp;
        p.target = self.process.mp;
        
        p.inputs(:,1:self.model.nx*self.model.xlags) = bsxfun(@times,self.xp(:,1:self.model.nx*self.model.xlags),reshape(repmat(self.data.sdx,self.model.xlags,1),1,self.model.xlags*self.model.nx));
        p.inputs(:,self.model.nx*self.model.xlags+1:end) = self.xp(:,self.model.nx*self.model.xlags+1:end)*self.data.sdy;
        
        p.target = p.target*self.data.sdy;
        
        self.xp = p.inputs;
        self.process.mp = p.target;
        self.process.vp = self.process.vp*self.data.sdy^2;
        
        self.prediction_normalised = false;
    end

elseif self.data.train.normalised == false
    
    warning('Prediction made on unnormalised data, cannot denormalise')
    
elseif self.prediction_normalised == false
    
    warning('Prediction already denormalised')
   

end

