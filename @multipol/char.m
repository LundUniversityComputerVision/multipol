function s = char(mp,xyzw,prec)
% MULTIPOL/CHAR
% Convert polynomial expression to readable string representation
if nargin < 2
    xyzw = true;
end
if nargin < 3
    prec = [];
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
    if (isreal(mp(k).coeffs(1)) && mp(k).coeffs(1)<0), c = '-'; end
    c = [c t];
    for i=2:nterms(mp(k))
        pm = ' + ';
        if isreal(mp(k).coeffs(i)) && mp(k).coeffs(i)<0
            pm = ' - ';
        end
        c = [c pm term2str(mp(k),i)];
    end
    s{k} = c;
end

if numel(mp) == 1
    s = s{1};
end

function s = n2s(c,prec)
    if isreal(c)
        % The things we do for backwards compatability...
        c = abs(c);
    end
    if ~isempty(prec)
        s = num2str(c,prec);
    else
        s = num2str(c);
    end
    if ~isreal(c)
        s = ['(' s ')'];
    end
end

function c = term2str(p,t)
    c = '';
    jj = find(p.monomials(:,t)~=0)';
    unit_coeff = p.coeffs(t) == 1 || p.coeffs(t) == -1;
    if ~(unit_coeff) || isempty(jj)
        c = [c n2s(p.coeffs(t),prec)];
    end
    if ~isempty(jj) && ~unit_coeff
        c = [c '*'];
    end
    for j=1:numel(jj)
        if j > 1
            c = [c '*'];
        end
        if xyzw && n <= 4
            name = names{jj(j)};
        else
            name = sprintf('x%u',jj(j));
        end
        if p.monomials(jj(j),t) ~= 1
            c = [c sprintf('%s^%d',name,p.monomials(jj(j),t))];
        else
            c = [c sprintf('%s',name)];
        end
    end
end
end
