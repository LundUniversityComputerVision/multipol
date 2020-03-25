function [p ia] = sort(p,order)
% MULTIPOL/SORT operator
% Sorts the monomials and removes double terms

if nargin<2
	order = 'plex';
end

for i=1:numel(p)
	m = p(i).monomials;
	
	if ~isempty(m)
		switch order
			case 'plex'
				[~,ia,ib] = unique(-m','rows');

			case 'grlex'
				[~,ia,ib] = unique([-sum(m,1)' -m'],'rows');

			case 'grevlex'
				[~,ia,ib] = unique([-sum(m,1)' fliplr(m')],'rows');

			otherwise
				error('Unknown monomial order');
		end
		
		p(i).monomials = m(:,ia);
		
		% This is fast but looks weird. This should be changed if there is
		% a more appropriate built-in function.
		c = full(sparse(ones(size(ib)),ib,p(i).coeffs,1,length(ia)));
		p(i).coeffs = c;
	else
		p.coeffs = sum(p.coeffs(:));
	end
end

