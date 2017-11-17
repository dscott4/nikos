function [ K ] = RBF( self, xp, xq, hyps, idiff )
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
    
    
    switch idiff
        case 0
            P = -pdist2(xp./ll,xq./ll).^2./2;
            %P = -pdist2(xp,xq).^2./2./ll.^2;
            K = sf2*exp(P)+sn2*eye(npts_p,npts_q);
        case 1
            P = -pdist2(xp./ll,xq./ll).^2./2;
            %P = -pdist2(xp,xq).^2./2./ll.^2;
            K = sf2*exp(P);
        case 2
            P = -pdist2(xp./ll,xq./ll).^2./2;
            %P = -pdist2(xp,xq).^2./2./ll.^2;
            K = -2*sf2*P*exp(P);
        case 3
            K = sn2*eye(npts_p,npts_q);
    end
    
else
    
    switch idiff
        case 0
            P = -pdist2(bsxfun(@rdivide,xp,ll),bsxfun(@rdivide,xq,ll)).^2./2;
            K = sf2*exp(P)+sn2*eye(npts_p,npts_q);
        case 1
            P = -pdist2(bsxfun(@rdivide,xp,ll),bsxfun(@rdivide,xq,ll)).^2./2;
            K = sf2*exp(P);
        case D+2
            K = sn2*eye(npts_p,npts_q);
        otherwise
            P = -pdist2(bsxfun(@rdivide,xp,ll),bsxfun(@rdivide,xq,ll)).^2./2;
            K = sf2*exp(P);
            K = K.*pdist2(bsxfun(@rdivide,xp(:,idiff-1),ll(idiff-1)),bsxfun(@rdivide,xq(:,idiff-1),ll(idiff-1)));
    end
    
    
end





end

