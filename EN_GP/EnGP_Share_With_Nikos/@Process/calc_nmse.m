function [ self ] = calc_nmse( self, y )
%CALC_NMSE 

resid = bsxfun(@minus,self.mp,y);
self.nmse = zeros(1,size(resid,2));
for i = 1:size(resid,2)
    self.nmse(i) =(resid(:,i)'*resid(:,i))*100/length(self.mp(:,i))/var(y);
end

end

