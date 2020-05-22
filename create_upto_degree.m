function p = create_upto_degree(vars_degree,max_degree)
% CREATE_UPTO_DEGREE Create all monomials up to a degree
% p = CREATE_UPTO_DEGREE(vars_degree,max_degree) creates a polynomial
% consisting of all monomials of degree up to the numbers in var_degree.
% The maximum total degree accepted is max_degree.

if nargin == 1
   max_degree = inf;
end

vars_degree = min(vars_degree,max_degree);

nvars = length(vars_degree);
degs = zeros(nvars,1);
mons = [];
done = false;
while ~done
    mons = [mons degs];
    for i = 1:nvars
        degs(i) = degs(i) + 1;
        if degs(i) > vars_degree(i) || sum(degs) > max_degree
            degs(i) = 0;
            if i == nvars
                done = true;
            end
        else
            break;
        end
    end
end

coeffs = ones(1,size(mons,2));
p = multipol(coeffs,mons);
p = sort(p);
