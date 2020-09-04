function q = gauss4(f, a, b, panels)
%computes the approx to I = integral a to b of f(x) dx by gauss 2 points
x1  = -0.861136311594052; x2  = 0.861136311594052;
x3  = -0.339981043584856; x4  = 0.339981043584856;
w12 =  0.347854845137454; w34 = 0.652145154862546;
h = (b - a)/panels;
q = 0;
for i = 1:panels
    r = a + (i-1)*h; s = a + i*h; % start and end of current interval
    t1 = ((s - r) * x1 + r + s) / 2; t2 = ((s - r) * x2 + r + s) / 2;
    t3 = ((s - r) * x3 + r + s) / 2; t4 = ((s - r) * x4 + r + s) / 2;
    q = q + w12 * (f(t1) + f(t2)) + w34 * (f(t3) + f(t4));
end
q = h*0.5*q; % scalling the weights 
end
