% function [r, it, rall, res, range] = bisect(fun, a, b, tol, maxit)
function [r, it, rall, res, range] = bisect(fun, a, b, tol, maxit)

if (nargin < 4), tol = 10^(-6); end
if (nargin < 5), maxit = ceil(log2(abs(b-a)/tol)); end

r = a; it = 0; rall = [a b]; range(1, 1:2) = [a b];
fa = feval(fun, a); sfa = sign(fa);
fb = feval(fun, b); sfb = sign(fb);
res = [fa fb];
if sfa*sfb > 0
    error('bisect -- error: no change of sign');
elseif sfa == 0
    r = a; return;
elseif sfb == 0
    r = b; return;
end
for it = 1:maxit
    m = a + (b-a)/2; %(a+b)/2;
    rall = [rall m];
    fm = feval(fun, m); sfm = sign(fm);
    res = [res fm];
    if abs(b-a)/2 <= tol | sfm == 0
        r = m;
        break;
    end
    if sfa*sfm > 0
        a = m;
    else
        b = m;
    end
    range(it+1, 1:2) = [a b];
end
r = m;
if abs(b-a)/2 > tol & sfm ~= 0
    disp('bisect -- warning: did not converge');
end


