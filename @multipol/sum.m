function S = sum(X,DIM)
%SUM Sum of elements.
%   S = SUM(X) is the sum of the elements of the vector X. If X is a matrix,
%   S is a row vector with the sum over each column. For N-D arrays,
%   SUM(X) operates along the first non-singleton dimension.
%
%   S = SUM(X,'all') sums all elements of X.
%
%   S = SUM(X,DIM) sums along the dimension DIM.

if nargin < 2
    DIM = find(size(X) ~= 1,1);
    if isempty(DIM)
        DIM = 1;
    end
elseif strcmp(DIM,'all')
    S = sum(X(:));
    return
end

Ssize = size(X);
Ssize(DIM) = 1;
S = multipol()*zeros(Ssize);

subs = cell(ndims(X),1);
subs(:) = {':'};
ss = substruct('()',subs);

for i = 1:size(X,DIM)
    ss.subs{DIM} = i;
    S = S+subsref(X,ss);
end
