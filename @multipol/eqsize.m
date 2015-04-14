function varargout = eqsize(varargin)
% MULTIPOL/EQSIZE Resize internal monomial matrices to consistent size between all input objects
m = 0;
for a=1:nargin
	p1 = varargin{a};
	for i=1:numel(p1)
		m = max(m,size(p1(i).monomials,1));
	end
end
for a=nargin:-1:1
	p1 = varargin{a};
	for i=1:numel(p1)
		if size(p1(i).monomials,1)<m
			p1(i).monomials(m,:) = 0;
		end
	end
	varargout{a} = p1;
end
