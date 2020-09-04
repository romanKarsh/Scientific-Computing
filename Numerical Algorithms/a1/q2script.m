xi2 = linspace(0, 1, 3);
yi2 = exp(-xi2);
xi3 = linspace(0, 1, 4);
yi3 = exp(-xi3);

p2 = polyfit(xi2, yi2, length(xi2) - 1); % interpolating polynomials 
p3 = polyfit(xi3, yi3, length(xi3) - 1);
e = exp(1);
p1 = [(1-e)/e, 1]; % computed by hand earlier
p3H = [1-3/e, 4/e-1, -1, 1];

x = linspace(0, 1, 100);
v1d = polyvald(p1, x);
v2d = polyvald(p2, x);
v3d = polyvald(p3, x);
v3Hd = polyvald(p3H, x);
vfd = -exp(-x);

figure(1);
plot(x, v1d, 'r-', x, v2d, 'm--', x, v3d, 'k:', x, v3Hd, 'b-.', x, vfd, 'k-');
legend("v1'", "v2'", "v3'", "v3H'", "vf'", 'Location', "southeast");
title("derivative values of polynomial interpolation, p'(x) vs x");
xlabel('x');
ylabel("p'(x)");

figure(2);
plot(x, vfd-v1d, 'r-', x, vfd-v2d, 'm--', x, vfd-v3d, 'k:', x, vfd-v3Hd, 'b-.');
legend("vf'-v1'", "vf'-v2'", "vf'-v3'", "vf'-v3H'", 'Location', "southeast");
title("true derivative value minus polynomial interpolation, f'(x)-p'(x) vs x");
xlabel('x');
ylabel("f'(x)-p'(x)");

mv1 = max(abs(vfd-v1d));
mv2 = max(abs(vfd-v2d));
mv3 = max(abs(vfd-v3d));
mv3H = max(abs(vfd-v3Hd));
fprintf("max of |vf' - v1'| is %22.15e\n", mv1);
fprintf("max of |vf' - v2'| is %22.15e\n", mv2);
fprintf("max of |vf' - v3'| is %22.15e\n", mv3);
fprintf("max of |vf' - v3H'| is %22.15e\n", mv3H);
