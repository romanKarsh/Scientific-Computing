F = {@(x)x^(5/2), @(x)x^(7/2), @(x)x^(9/2), @(x)x^(11/2), @(x)x^(13/2), ...
    @(x)x^(15/2), @maxfun, @branfun};
% additional functions to check that the gauss rules are exact where they
% need to be.
%@(x)4*x^3+6*x^2-7*x+5, @(x)x^3, @(x)x^7, @(x)2*x^7-3*x^6-2*x^5+x^4-4*x^3+5
label = ["f(x) = x^(5/2)", "f(x) = x^(7/2)", "f(x) = x^(9/2)", ...
    "f(x) = x^(11/2)", "f(x) = x^(13/2)", "f(x) = x^(15/2)", ...
    "f(x) = max(x-1/3, 0)", "f(x) = if 0<=x<1/3 0 else 1"];
% "f(x) = 4*x^3 + 6*x^2 - 7*x + 5", "f(x) = x^3", "f(x) = x^7" 
% "f(x) = 2*x^7-3*x^6-2*x^5+x^4-4*x^3+5"];
exact = [2/7 2/9 2/11 2/13 2/15 2/17 2/9 2/3];
% 9/2 1/4 1/8 1549/420
for p = 1:length(F)
    f = F{p};
    fprintf("\n" + label(p) + ", I = %13.11f\n", exact(p));
    Qm = ones(1, 6); Qg2 = ones(1, 6); Qg4 = ones(1, 6); Q = exact(p);
    for i = 1:6
        n = 2^(i-1);
        Qm(i) = compmid(f, 0, 1, n);
        Qg2(i) = gauss2(f, 0, 1, n);
        Qg4(i) = gauss4(f, 0, 1, n);
        fprintf('%3d %13.11f %13.11f %13.11f %9.2e %9.2e %9.2e\n', ...
            n, Qm(i), Qg2(i), Qg4(i), Q-Qm(i), Q-Qg2(i), Q-Qg4(i));
    end
    for i = 1:5
        n=2^(i-1);
        convm = log2((Q-Qm(i))/(Q-Qm(i+1)));
        convg2 = log2((Q-Qg2(i))/(Q-Qg2(i+1)));
        convg4 = log2((Q-Qg4(i))/(Q-Qg4(i+1)));
        fprintf('(%3d, %3d) %13.2f %13.2f %13.2f\n', ... 
            n, 2*n, convm, convg2, convg4);
    end
end

function y = maxfun(x)
    if x <= 1/3
        y = 0;
    else
        y = x - 1/3;
    end
end
function y = branfun(x)
    if x < 1/3
        y = 0;
    else
        y = 1;
    end
end