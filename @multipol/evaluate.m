function f = evaluate(p1,x)
% f = evaluate(p1,x);
% MULTIPOL/EVALUATE operator
% Calculates the value of the polynomial p1
% at the point x

if isempty(p1) || isempty(x)
	f = [];
	return;
end

p1 = eqsize(p1);

if nvars(p1)~=size(x,1)
	error('size(x,1) must equal nvars(p1)');
end

if numel(p1)>1
	if size(x,2)==1
		m = size(p1,1);
		n = size(p1,2);
		for i=m:-1:1
			for j=n:-1:1
				f(i,j) = evaluate(p1(i,j),x);
			end
		end
	else
		for j=size(x,2):-1:1
			for i=numel(p1):-1:1
				f(i,j) = evaluate(p1(i),x(:,j));
			end
		end
	end
else
	if(numel(p1.coeffs)==0)
		f = zeros(1,size(x,2));
		return;
	end
	for j=size(x,2):-1:1
		f(1,j) = sum(p1.coeffs.*prod(bsxfun(@power,x(:,j),p1.monomials),1));
	end
end