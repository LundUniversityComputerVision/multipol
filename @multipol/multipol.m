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
	
	elseif isa(coeffs,'sym')
        % Still a bit hacky, but better than before
        p = expand(coeffs);
        vars = sort(symvar(p));
        nvars = numel(vars);
        
        all_vars = char(vars);
        all_vars = erase(all_vars,"matrix([[");
        all_vars = erase(all_vars,"]])");
        all_vars = split(all_vars, ', ');
        
        pstr = char(p);
        pstr = strrep(pstr,' - ',' + -');
        terms = split(pstr, ' + ');
        nterms = numel(terms);
        
        monomials = zeros(nvars, nterms);
        coeffs = zeros(1, nterms);
        
        for j = 1:nterms
            t = terms{j};
            if t(1) == '-' && ~isempty(regexp(t(2), '[a-z]', 'once'))
                t = ['-1*', t(2:end)];
            elseif ~isempty(regexp(t(1), '[a-z]', 'once'))
                t = ['1*', t];
            end
            
            tmp = split(t, '*');
            for k = 1:numel(tmp)
                u = split(tmp{k}, '^');
                index = find(strcmp(all_vars, u{1}));
                
                if isempty(index)
                    % This is a constant
                    coeffs(j) = str2double(u{1});
                else
                    % This is a variable, possibly with a power
                    if numel(u) == 1
                        monomials(index,j) = 1;
                    elseif numel(u) == 2
                        monomials(index,j) = str2double(u{2});
                    else
                        error('Something went wrong.')
                    end
                end
            end
        end
        s = multipol(coeffs, monomials);
        s = sort(s);
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
