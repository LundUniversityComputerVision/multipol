function s = char(mp,xyzw,prec)
% MULTIPOL/CHAR
% Convert polynomial expression to readable string representation
if nargin<2
	xyzw = true;
end
if nargin<3
	numstr = @num2str;
else
	numstr = @(s)num2str(s,prec);
end

s = cell(size(mp));
mp = eqsize(mp);

% If few variables and xyzw==true, use x, y, z, w instead of numbered x's.
n = nvars(mp);
n = max(n(:));
names = {'x','y','z','w'};

for k=1:numel(mp)
	
	c = '';
	t = term2str(mp(k),1);
	if mp(k).coeffs(1)<0, c = '-'; end
	c = [c t];
	for i=2:nterms(mp(k))
		t = term2str(mp(k),i);
		pm = ' + ';
		if mp(k).coeffs(i)<0, pm = ' - '; end
		c = [c pm term2str(mp(k),i)];
	end
	
	s{k} = c;
end

if numel(mp)==1
	s = s{1};
end

	function c = term2str(p,t)
		c = '';
		jj = find(p.monomials(:,t)~=0)';
		if abs(p.coeffs(t))~=1 || isempty(jj)
			c = [c numstr(abs(p.coeffs(t)))];
		end
		if ~isempty(jj) && abs(p.coeffs(t))~=1
			c = [c '*'];
		end
		for j=1:numel(jj)
			if j>1
				c = [c '*'];
			end
			if xyzw && n<=4
				name = names{jj(j)};
			else
				name = sprintf('x%u',jj(j));
			end
			if p.monomials(jj(j),t)~=1
				c = [c sprintf('%s^%d',name,p.monomials(jj(j),t))];
			else
				c = [c sprintf('%s',name)];
			end
		end
	end

end








