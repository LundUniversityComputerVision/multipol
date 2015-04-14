function h = hash(p)
% MULTIPOL/HASH Compute a "hash" of the polynomial p for efficient set operations.

m = max(abs(p.coeffs))+1; % Divide to prevent overflow in char conversion
A = [p.coeffs/m*65535; p.monomials]; % Dangerous! There is certain precision loss here 
% which might make polynomials differing only slightly in coefficients hash to the same string.
B = [abs(A); sign(A)+1];
h = char([log(m+1); B(:)])';


