function [ self ] = set_data( self, x, y, id )
%SET_DATA


if nargin < 4
    id = 'train';
end

if self.data.(id).normalised == false && self.props.normalise == true

    self.data.(id).set_data(x,y);
    self.data.normalise();
    
else
    
    self.data.(id).set_data(x,y);
    
end



if strcmp(id,'train') && ~isempty(self.model)
    self.model.set_model_data(self.data.train);
    if ~isempty(self.process)
        self.process.set_process_data(self.model.data);
    end
end


end

