function [ self ] = plot( self, x, y )
%PLOT

if nargin < 2
    switch self.predict_on
        case 'train'
            x = self.data.train.inputs;
            y = self.data.train.target;
        case 'val'
            x = self.data.val.inputs;
            y = self.data.val.target;
        case 'test'
            x = self.data.test.inputs;
            y = self.data.test.target;
        otherwise
            error('Supply x and y data to plot prediction against')
    end
    
    if self.data.train.normalised == true && self.prediction_normalised == false
        self.denormalise_prediction();
        d.inputs = x;
        d.target = y;
        [~,d] = self.data.denormalise(d);
        x = d.inputs;
        y = d.target;
    end
    
end






if strcmp(self.props.plot_type,'ss')
    if size(x,2) == 1 && ~isa(self.model,'NARX')
        
        EnGP.gp_plot(self.xp,self.process.mp,self.process.vp,x,y);
                
    elseif size(x,2) == 1 && isa(self.model,'NARX')
        
        pp = (self.model.offset+1:length(x))';
        EnGP.gp_plot(self.xp,self.process.mp,self.process.vp,x,y);
       
    else
        error('Multidimensional input plotting is a work in progress!');
    end
    
elseif strcmp(self.props.plot_type,'output')
    
    if ~isa(self.model,'NARX')
        
        pp = (1:length(x))';
        EnGP.gp_plot(pp,self.process.mp,self.process.vp,pp,y);
        
    elseif isa(self.model,'NARX')
        
        pp = (self.model.offset+1:length(x))';
        EnGP.gp_plot(pp,self.process.mp,self.process.vp,pp,y(self.model.offset+1:end));
        
    else
        error('Multidimensional input plotting is a work in progress!');
    end
    
end


end

