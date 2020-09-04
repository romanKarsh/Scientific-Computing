function x_out = BFGS(func, dfunc, x_min, x_0, n, a_max, tol, prt, it)
%Performs BFGS algorithm using the line search algorithm
%   func: is the function to minimize
%   dfunc: gradient of the function to minimize
%   x_min: the minimizer for the function
%   x_0: initial guess to the minimum
%   n: dimension of the input x_0
%   a_max: maximum step length allowed for line search algorithm
%   tol: stopping criterion (like 10.^-3)
%   prt: print two tables of numerical results (0 or 1)
%   it: print every it th line of tables
B = eye(n); % initial B is just the identity 
k = 0; x_k = x_0; f_k = func(x_k); df_k = dfunc(x_k); dfknorm = norm(df_k);
x_ks = x_k;
table2 = [];
if prt
    fprintf('\nk  \t\t\t x_k^T  \t\t\t f(x_k) \t  ||Vf(x_k)|| \n')
    fprintf('----------------------------------------------------------------\n') 
end
while dfknorm > tol
    if prt && rem(k, it) == 0 % table generating code
        fprintf('%d \t [', k);
        fprintf('%1.5g ', x_k);
        fprintf('] \t %12.5E \t %12.5E \n', f_k, dfknorm);
        if k > 0 % skip first iteration k=0 and only record every it iteration 
            dnow = norm(x_ks(:, k+1) - x_min);
            dpas = norm(x_ks(:, k) - x_min);
            table2 = [table2; k a_k dnow dnow/dpas dnow/(dpas^2)];
        end
    end
    p = - B * df_k;
    a_k = linesearch(func, dfunc, p, x_k, a_max, 0.001, 0.7);
    s = a_k * p;
    x_k = x_k + s;
    f_k = func(x_k);
    x_ks = [x_ks x_k];
    new_dfk = dfunc(x_k); % for the next iteration
    dfknorm = norm(new_dfk);
    k = k + 1;
    
    y = new_dfk - df_k;
    % 2.21 formula for inverse of B update
    po = 1 / (y' * s);
    B = (eye(n) - po*s*y')*B*(eye(n) - po*y*s') + po*(s*s');
    df_k = new_dfk;
    if po < 0  % make sure yTs is always positive
       fprintf("xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx");
    end
end
if prt 
    fprintf('\nk  \t\t a  \t\t |x_k - x*| \t|x_k - x*|      |x_k - x*| \n')
    fprintf('   \t     \t  \t \t\t\t      |x_{k-1} - x*|  |x_{k-1} - x*|^2\n')
    fprintf('----------------------------------------------------------------\n')
    fprintf('%-2.0f     %-9.6f      %-9.6f      %-9.6f     %-9.6f\n', table2')
end
x_out = x_k;
plot(x_ks');
legend('x(1)','x(2)');
xlabel('k');
ylabel('value of coordinate x');
title('graph of the iterates vs k');
end