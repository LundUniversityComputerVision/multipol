function s=multipol(coeffs,monomials)
% MULTIPOL/MULTIPOL constructor
% s = multipol(coeffs,monomials)
% s = multipol(d)


if nargin==0
	s.coeffs = 0;
	s.monomials = 0;
	s = class(s,'multipol');

elseif nargin==1
	if isa(coeffs,'multipol')
		s = coeffs;
	
	elseif isnumeric(coeffs)
		if numel(coeffs)==1
			s.coeffs = sum(coeffs(:));
			s.monomials = 0;
			s = class(s,'multipol');
		else
			for i=numel(coeffs):-1:1
				s(i) = multipol(coeffs(i));
			end
			s = reshape(s,size(coeffs));
		end
	
	elseif isa(coeffs,'sym') % Så fulhackat så man skäms... varning för eventuella fel!
		S = coeffs;
		vars = sort(symvar(S));
		nvar = numel(vars);
		
		fprintf('Substituting [')
		for i=1:nvar-1
			fprintf('%s, ',char(vars(i)));
		end
		fprintf('%s] --> [',char(vars(nvar)));
		for i=1:nvar-1
			fprintf('x%u, ',i);
		end
		fprintf('x%u]\n',nvar);
		
		varstr = char(vars);
		ind_gt = zeros(nvar,1);
		for i=1:nvar
			ind_gt(i) = regexp(varstr,['[^a-z]' char(vars(i)) '[^0-9]']);
		end
		for i=numel(S):-1:1
			pl = sym(mupadmex('poly2list',char(S(i))));
			nterms = numel(pl);
			m = zeros(nvar,nterms);
			coeffs = zeros(1,nterms);
			vars_i = sort(symvar(S(i)));
			ind = zeros(numel(vars_i),1);
			for t=1:numel(vars_i)
				ind(t) = find(ind_gt==regexp(varstr,['[^a-z]' char(vars_i(t)) '[^0-9]']));
			end
			for j=1:nterms
				d = pl(j);
				coeffs(j) = d(1);
				m(ind,j) = d(2)';
			end
			s(i,1) = multipol(coeffs,m);
		end
		
	end
	
elseif nargin==2 && isnumeric(coeffs) && isnumeric(monomials)
	
	if isempty(coeffs)
		coeffs = 0;
	end
	if isempty(monomials)
		monomials = 0;
	end
	if size(monomials,2)~=numel(coeffs)
		error('size(monomials,2)~=numel(coeffs)');
	end
	s.coeffs = coeffs;
	s.monomials = monomials;
	s = class(s,'multipol');
	
else
	error('Conversion to multipol not supported');
end
