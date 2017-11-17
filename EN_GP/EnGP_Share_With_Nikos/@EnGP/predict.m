function self = predict(self,data,options)

if self.data.train.normalised == true; self.prediction_normalised = true; end

if nargin < 2
    if isempty(self.data.test.inputs)
        data = 'train';
        fprintf('Predicting on training data\n')
    else
        data = 'test';
        fprintf('Predicting on testing data\n')
    end
end

if nargin < 3
    options.normalised = false;
    options.pred_type = 'all';
end

if ~isfield(options,'normalised') 
    normalised = false;
else
    normalised = options.normalised;
end

if ischar(data)
    xp = lower(data);
    self.predict_on = xp;
    self.xp = self.data.(xp).inputs;
else
    self.predict_on = 'external';
    if isstruct(data)
        if self.data.train.normalised == true
            self.xp = bsxfun(@rdivide,data.inputs,self.data.sdx);
        else
            self.xp = data.inputs;
        end
    else
        self.xp = data;
    end
end


% if normalised == false && self.data.train.normalised == true
%     self.xp = bsxfun(@rdivide,xp,self.data.sdx);
% end

if isa(self.model,'Static')
    
    self.process.predict_y(self.xp);
    
    
%     Kxx = self.process.kernel.(self.process.kernel.type)(self.process.inputs,self.process.inputs);
%     hyps_tmp = self.process.hyps;
%     hyps_tmp.sn2 = 0;
%     Kxs = self.process.kernel.(self.process.kernel.type)(self.process.inputs,self.xp,hyps_tmp);
%     Ksx = self.process.kernel.(self.process.kernel.type)(self.xp,self.process.inputs,hyps_tmp);
%     Kss = self.process.kernel.(self.process.kernel.type)(self.xp,self.xp,hyps_tmp);
%     
%     A = [Kxx Kxs;Ksx Kss];
%     
%     yt = [self.process.target;self.data.test.target];
%     
%     likelihood = log(det(A))+1/(2*pi)^(length(self.xp)/2)*exp(-0.5*yt'*(A\yt))
% 

    
elseif isa(self.model,'NARX')
    
   
    
    if ~ischar(data)
        if self.data.train.normalised == true
            p.inputs = bsxfun(@rdivide,data.inputs,self.data.sdx);
            p.target = bsxfun(@rdivide,data.target,self.data.sdy);
        else
            p.inputs = data.inputs;
            p.target = data.target;
        end
    else
        if self.data.train.normalised == true && self.data.(data).normalised == false
            self.data.normalise();
            p.inputs = self.data.(data).inputs;
            p.target = self.data.(data).target;
        else
            p.inputs = self.data.(data).inputs;
            p.target = self.data.(data).target;
        end
    end
    
    
    
    if ~isfield(options,'pred_type')
        options.pred_type = 'all';
    end
    
    if strcmpi(options.pred_type,'osa') % Predict a one step ahead case
        
        self.xp = NARX.narx_input(self.model,p); % Set NARX inputs with true outputs
        self.process.predict_y(self.xp);        
        
    elseif strcmpi(options.pred_type,'mpo') % Do a full model prediction
        
        xp = NARX.narx_input(self.model,p); 
        npred_pnts = size(self.xp,1);
        self.xp = xp(1,:);
        
        mp = zeros(self.model.np,1);
        vp = zeros(self.model.np,1);
        
        self.process.predict_y(self.xp);
        mp(1,1) = self.process.mp;
        vp(1,1) = self.process.vp;
        
        nyin = self.model.ylags;
              
        for pnt = 2:npred_pnts
            % Update y in xp
            self.xp(2:nyin) = self.xp(1:nyin-1);
            self.xp(1) = mp(pnt-1,1);
            
            % Update x in xp
            self.xp(nyin+1:end) = xp(pnt,nyin+1:end);

            % Predict
            self.process.predict_y(self.xp);
            
            % Update mean and variance
            mp(pnt,1) = self.process.mp;
            vp(pnt,1) = self.process.vp;
            
        end
        
        self.process.mp = mp;
        self.process.vp = vp;
       
        
    elseif strcmp(options.pred_type,'all')
        
        
        self.xp = NARX.narx_input(self.model,p); % Set NARX inputs with true outputs
        npred_pnts = size(self.xp,1);
        self.process.predict_y(self.xp);
        
        mp = zeros(length(self.process.mp),2);
        vp = zeros(length(self.process.mp),2);
        
        mp(:,1) = self.process.mp;
        vp(:,1) = self.process.vp;
        
        xp = NARX.narx_input(self.model,p); 
        self.xp = xp(1,:);

        self.process.predict_y(self.xp);
        mp(1,2) = self.process.mp;
        vp(1,2) = self.process.vp;
        
        nyin = self.model.ylags;
              
        
        for pnt = 2:npred_pnts
            % Update y in xp
            self.xp(2:nyin) = self.xp(1:nyin-1);
            self.xp(1) = mp(pnt-1,2);
            
            % Update x in xp
            self.xp(nyin+1:end) = xp(pnt,nyin+1:end);

            % Predict
            self.process.predict_y(self.xp);
            
            % Update mean and variance
            mp(pnt,2) = self.process.mp;
            vp(pnt,2) = self.process.vp;
            
        end
        
        self.process.mp = mp;
        self.process.vp = vp;
        
    else
        error('Unknown prediction type')
    end
        
        
end

if ~strcmp(self.predict_on,'external')
    if isa(self.model,'Static')
        self.process.calc_nmse(self.data.(self.predict_on).target);
        fprintf('Model error: %.8f\n',self.process.nmse)
    elseif isa(self.model,'NARX')
        self.process.calc_nmse(self.data.(self.predict_on).target(self.model.offset+1:end));
        fprintf('Model error: %.8f\n',self.process.nmse)
    end
end

if self.data.train.normalised == true
    self.denormalise_prediction();
end

end