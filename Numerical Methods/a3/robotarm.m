function [r, it, rall, res] = robotarm(a, b, p, r, tol, maxit)
it = 0;
the = r(1,1);
fi = r(2,1);
f = [a*cos(the)+b*cos(the+fi)-p(1,1); a*sin(the)+b*sin(the+fi)-p(2,1)];
res = norm(f);
rall = [the; fi];
for it = 1:maxit
    if norm(f) <= tol % checked first so we don't have 3 evals per iter
        break;
    end
    J = [-a*sin(the)-b*sin(the+fi) -b*sin(the+fi); ...
          a*cos(the)+b*cos(the+fi) b*cos(the+fi)];
    s = J\(-f);
    
    the = the + s(1,1);
    fi = fi + s(2,1);
    f = [a*cos(the)+b*cos(the+fi)-p(1,1); a*sin(the)+b*sin(the+fi)-p(2,1)];
    res = [res norm(f)];
    rall = [rall [the; fi]];
end
it = it - 1;
r(1,1) = the;
r(2,1) = fi;
