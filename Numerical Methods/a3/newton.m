function [r, it, rall, res] = newton(fun, a, tol, maxit)

if (nargin < 3), tol = 10^(-6); end
rall = []; res = [];
[vf, df] = feval(fun, a);
% based on the assumption that num of correct digits doubles every iter
if (nargin < 4), maxit = ceil(log2(abs(log2(tol)/log2(abs(vf))))) + 1; end
for it = 1:maxit
    if df == 0
        error('newton -- error: derivative is 0');
    end
    rall = [rall a];
    res = [res, vf];
    a = a - vf/df;
    % checked with last iterations vf, so only 2 fun evals per iteration
    if abs(vf) <= tol
        break;
    end
    [vf, df] = feval(fun, a);
end
it = it - 1;
r = a;