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
v1 = polyval(p1, x);
v2 = polyval(p2, x);
v3 = polyval(p3, x);
v3H = polyval(p3H, x);
vf = exp(-x);

figure(1);
plot(x, v1, 'r-', x, v2, 'm--', x, v3, 'k:', x, v3H, 'b-.', x, vf, 'k-');
legend('v1', 'v2', 'v3', 'v3H', 'vf');
title('polynomial interpolation, p(x) vs x');
xlabel('x');
ylabel('p(x)');

figure(2);
plot(x, vf-v1, 'r-', x, vf-v2, 'm--', x, vf-v3, 'k:', x, vf-v3H, 'b-.');
legend('vf-v1', 'vf-v2', 'vf-v3', 'vf-v3H', 'Location', 'southeast');
title('true value minus polynomial interpolation, f(x)-p(x) vs x');
xlabel('x');
ylabel('f(x)-p(x)');

mv1 = max(abs(vf-v1));
mv2 = max(abs(vf-v2));
mv3 = max(abs(vf-v3));
mv3H = max(abs(vf-v3H));
fprintf('max of |vf - v1| is %22.15e\n', mv1);
fprintf('max of |vf - v2| is %22.15e\n', mv2);
fprintf('max of |vf - v3| is %22.15e\n', mv3);
fprintf('max of |vf - v3H| is %22.15e\n', mv3H);
