function x_out = steepestDescent(func, dfunc, x_min, x_0, a_0, fix, tol, prt, it)
%Performs steepest descent on the given func
%   func: is the function to minimize
%   dfunc: gradient of the function to minimize
%   x_min: the minimizer for the function
%   x_0: initial guess to the minimum
%   a_0: initial step size to use in Backtracking step search
%   fix: 0 or 1, fixed step size (a_0) or use backtracking
%   tol: stopping criterion (like 10.^-3)
%   prt: print two tables of numerical results (0 or 1)
%   it: print every it th line of tables
k = 0; x_k = x_0; f_k = func(x_k); df_k = dfunc(x_k); dfknorm = norm(df_k);
x_ks = x_k;
past_a = a_0;
table2 = [];
if prt
    fprintf('\nk  \t\t\t x_k^T  \t\t\t f(x_k) \t  ||Vf(x_k)|| \n')
    fprintf('----------------------------------------------------------------\n') 
end
while dfknorm > tol
    if rem(k, it) == 0 && k > 0 % skip first iteration k=0 and only record every it iteration 
        dnow = norm(x_ks(:, k+1) - x_min);
        dpas = norm(x_ks(:, k) - x_min);
        table2 = [table2; k past_a dnow dnow/dpas dnow/(dpas^2)];
    end
    a_k = a_0;
    if not(fix)
        a_k = backTrack(func, 0.5, 0.001, a_0, -df_k, df_k, x_k, f_k);
    end
    if prt && rem(k, it) == 0
        fprintf('%d \t [', k);
        fprintf('%1.5g ', x_k);
        fprintf('] \t %12.5E \t %12.5E \n', f_k, dfknorm);
    end
    past_a = a_k;
    x_k = x_k - a_k * df_k;
    f_k = func(x_k);
    df_k = dfunc(x_k);
    dfknorm = norm(df_k);
    x_ks = [x_ks x_k];
    k = k + 1;
end
if prt 
    fprintf('\nk  \t\t a  \t\t |x_k - x*| \t|x_k - x*|      |x_k - x*| \n')
    fprintf('   \t     \t  \t \t\t\t      |x_{k-1} - x*|  |x_{k-1} - x*|^2\n')
    fprintf('----------------------------------------------------------------\n')
    fprintf('%-2.0f     %-9.6f      %-9.6f      %-9.6f     %-9.6f\n', table2')
end
x_out = x_k;
plot(x_ks'); % x_ks(1, :) first cordinates % x_ks(2, :) second cordinates
legend('x(1)','x(2)');
xlabel('k');
ylabel('value of coordinate x');
title('graph of the iterates vs k');
end