function [r, it, rall, diff] = fixedpt(fun, a, tol, maxit)

if (nargin < 3), tol = 10^(-6); end
tol
% take the maxit to be a 'worst' case (linear convergence with asymptotic
% error constant to be 0.95)
if (nargin < 4), maxit = ceil(log2(abs(tol))/log(0.95)); end
new_a = feval(fun, a);
it = 0; rall = a; diff = new_a - a;
if abs(diff) <= tol
    r = a;
    return;
end
a = new_a;

for it = 1:maxit
    new_a = feval(fun, a);
    temp = new_a - a;
    diff = [diff temp];
    rall = [rall a];
    a = new_a;
    if abs(temp) <= tol
        break;
    end
end
r = a;