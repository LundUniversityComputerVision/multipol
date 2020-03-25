function [C,ia,ic] = unique(A)
% MULTIPOL/UNIQUE

if ~isvector(A)
    error('NYI: multipol/unique does not yet support matrix inputs.');
end

if length(A) == 1
    C = A;
    ia = 1;
    ic = 1;
    return;
end

[As,ind] = sortpolys(A);

keep = [true As(1:end-1) ~= As(2:end)];
C = As(keep);
ia = ind(keep);

if nargout > 2
    ic = zeros(size(As));
    ic(keep) = 1:length(ia);
    for i=1:length(ic)
        if ic(i) == 0
            ic(i) = ic(i-1);
        end
    end
    ic(ind) = ic;
end

