function [ self ] = predict_y( self, xp )
%PREDICT_Y 

hyps = self.kernel.hyps;
hyps.sn2 = 0;
KP = self.kernel.(self.kernel.type)(xp,self.inputs,hyps);

self.mp = KP*self.alpha;
v = ((self.R')\(KP'))/sqrt(self.sl);
if ~strcmp(self.kernel.type,'Independent')
    self.vp = bsxfun(@minus,self.hyps.sf2+self.hyps.sn2,diag(v'*v));
else
    self.vp = bsxfun(@minus,sum(self.hyps.sf2)+self.hyps.sn2,diag(v'*v));
end


end

