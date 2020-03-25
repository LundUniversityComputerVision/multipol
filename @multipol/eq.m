function e = eq(p1,p2)

if numel(p1) > 1 && numel(p2) == 1
	e = false(size(p1));
	for i=1:numel(p1)
		e(i) = p1(i) == p2;
	end
	return;
end
if numel(p1) == 1 && numel(p2) > 1
	e = false(size(p2));
	for i=1:numel(p2)
		e(i) = p2(i) == p1;
	end
	return;
end
if numel(p1) > 1 && numel(p2) > 1
    if ~all(size(p1) == size(p2))
        error('Inputs must be of equal length');
    end
	e = false(size(p1));
	for i = 1:size(p1,1)
		for j = 1:size(p1,2)
			e(i,j) = p1(i,j) == p2(i,j);
		end
	end
	return;
end

if isnumeric(p1)
	p1 = multipol(p1);
end
if isnumeric(p2)
	p2 = multipol(p2);
end
[p1,p2] = eqsize(p1,p2);
e = false;
if isnumeric(p1)
	if any(bsxfun(@times,p2.coeffs,p2.monomials)~=0), return; end
	if p2.coeffs(sum(p2.monomials,1)==0)~=p1, return; end % there should be at most one constant monomial, if not something will break.
	e = true;
	return;
end
if isnumeric(p2)
	if any(bsxfun(@times,p1.coeffs,p1.monomials)~=0), return; end
	if p1.coeffs(sum(p1.monomials,1)==0)~=p2, return; end
	e = true;
	return;
end

if ~isequal(p1.coeffs,p2.coeffs)
    return;
end
e = isequal(p1.monomials,p2.monomials);

