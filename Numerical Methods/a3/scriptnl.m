format compact
tol = 1e-7;
a = pi/4; b = pi/2;
root = fzero(@ff, pi/2); % 1.265423705869335 % 1.478170266430321

[r, it, rall, res] = bisect(@ff, a, b, tol);
disp('bisection')
disp('nit  root approx     residual    error')
for i = 1:it+2
    err(i) = root - rall(i);
    fprintf('%3d %15.12f %11.3e %11.3e', i-2, rall(i), res(i), err(i));
    fprintf('\n');
end

[r, it, rall, res] = newton(@ff, b, tol);
disp('Newton')
disp('nit  root approx     residual    error')
for i = 1:it+1
    err(i) = root - rall(i);
    fprintf('%3d %15.12f %11.3e %11.3e', i-1, rall(i), res(i), err(i));
    fprintf('\n');
end

[r, it, rall, diff] = fixedpt(@phi, b, tol);
disp('a fixed-point iteration')
disp('nit  root approx     phi(x)-x    error')
for i = 1:it+1
    err(i) = root - rall(i);
    fprintf('%3d %15.12f %11.3e %11.3e', i-1, rall(i), diff(i), err(i));
    fprintf('\n');
end

