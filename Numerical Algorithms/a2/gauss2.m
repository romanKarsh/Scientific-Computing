function q = gauss2(f, a, b, panels)
%computes the approx to I = integral a to b of f(x) dx by gauss 2 points
x1 = -sqrt(3)/3; x2 = sqrt(3)/3; % sqrt(3)/3;
w12 = 1;
h = (b - a)/panels;
q = 0;
for i = 1:panels
    r = a + (i-1)*h; s = a + i*h; % start and end of current interval
    t1 = ((s - r) * x1 + r + s) / 2; t2 = ((s - r) * x2 + r + s) / 2;
    q = q + w12 * (f(t1) + f(t2));
end
q = h*0.5*q; % scalling the weights 
end

