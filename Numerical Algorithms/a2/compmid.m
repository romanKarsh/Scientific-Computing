function q = compmid(f, a, b, panels)
%computes the approx to I = integral a to b of f(x) dx by midpoint rule
h = (b - a)/panels;
q = 0;
for i = 1:panels
    q = q + f(a+(i-0.5)*h);
end
q = q * h;

