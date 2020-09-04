function [y] = polyvald(p, x)
n = length(p) - 1;
newP = zeros(1, n);
for i = 1:n
    newP(i) = (n-i+1) * p(i);
end
y = polyval(newP, x);