function self = set_process(self,process, kernel)

if  ~isempty(self.model.data.inputs)
    process_build = process;
    self.process = process_build(self.model.data,kernel);
else
    error('No training data to build process with')
end

if isempty(self.props.lims)
    self.props.lims = [repmat(-4,1,self.process.kernel.nhyp-1) -10;repmat(6,1,self.process.kernel.nhyp-1) -2];
end

end