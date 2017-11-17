function [ K ] = Matern32( self, xp, xq, hyps, idiff )
%RBF Radial basis kernel

if nargin< 5
    idiff = 0;
end

if size(xp,2) == size(xq,2)
    D = size(xp,2);
else
    error('Input dimensionality not consistent');
end

if nargin < 4
    sf2 = self.hyps.sf2;
    ll = self.hyps.ll;
    sn2 = self.hyps.sn2;
else
    sf2 = hyps.sf2;
    ll = hyps.ll;
    sn2 = hyps.sn2;
end

if ~isempty(self.active_dims)
    xp = xp(:,self.active_dims);
    xq = xq(:,self.active_dims);
end
    

npts_p = size(xp,1);
npts_q = size(xq,1 );

if self.ARD == false
    
    
        r = pdist2(xp,xq);
        
        switch idiff
            case 0
                % K
                K = sqrt(3).*r./ll;
                K = sf2*((1+K).*exp(-K))+sn2*eye(npts_p,npts_q);
                
            case 1
                % dK/dsf2
                K = sqrt(3)*r./ll;
                K = sf2*(1+K).*exp(-K);
            case 2
                % dK/dll
                K = sqrt(3*r/ll);
                K = (3*sf2.*r.^2.*exp(-K))./ll^2;
            case 3
                % dK/dsn2
                K = sn2*eye(npts_p,npts_q);
        end
        
        
    
else
    
    
    %% Matern Kernel nu = 3/2 with ARD
        
        r = pdist2(bsxfun(@rdivide,xp,sqrt(ll)),bsxfun(@rdivide,xq,sqrt(ll)));
        
        switch idiff
            case 0
                % K
                K = sf2*((1+r*sqrt(3)).*exp(-sqrt(3)*r))+sn2*eye(npts_p,npts_q);
                
            case 1
                % dK/d(ln(sf2))
                K = sf2*((1+r*sqrt(3)).*exp(-sqrt(3)*r))+sn2*eye(npts_p,npts_q);
            
            case D+2
                % dK/d(ln(sn2))
                K = sn2*eye(npts_p,npts_q);
                
            otherwise
                % dK/d(ln(ll))
                
                xl2 = pdist2(xp(:,idiff-1)./ll(idiff-1),xp(:,idiff-1)./ll(idiff-1)).^2;
                expK = exp(-sqrt(3)*r);
                K = -sqrt(3).*xl2.*expK + sqrt(3).*xl2.*(1+sqrt(3)*r)*expK;
                K = K*ll(idiff-1);
        end
    
   
    
end

end

