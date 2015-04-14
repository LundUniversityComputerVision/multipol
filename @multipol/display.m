function display(s)
% MULTIPOL/DISPLAY Command window display of a multivariate polynomial object;
%

if isequal(get(0,'FormatSpacing'),'compact')
	sp = '';
else
	sp = ' ';
end

if numel(s)==1
	disp(sp);
	disp([inputname(1),' = '])
	disp(sp);
	disp(s.coeffs)
	disp(' ');
	disp(s.monomials)
elseif numel(s)>50 || isempty(s)
	disp(sp);
	disp([inputname(1),' = '])
	disp(sp);
	siz = size(s);
	fprintf('   %u',siz(1));
	for i=2:length(siz)
		fprintf(' x %u',siz(i));
	end
	fprintf(' multipol object\n')
	disp(sp);
else
	disp(sp);
	disp([inputname(1),' = '])
	disp(sp);
	disp(char(s));
	disp(sp);
end