function x_out = trustRegion(func, dfunc, d2func, x_0, delta, delta_0, n, tol)
    %Performs steepest descent on the given func
    %   func: is the function to minimize
    %   dfunc: gradient of the function to minimize
    %   d2func: hessian of the function to minimize
    %   x_0: initial guess to the minimum
    %   delta: the maximum trust region size (> 0)
    %   delta_0: the initial delta
    %   n: parameter in the algorithm
    %   tol: stopping criterion (like 10.^-3)
    %   ==============================================
    %   x_out: return the iterates x 
    k = 0; x_k = x_0;
    delta_k = delta_0;
    x_out = x_k;
    while norm(dfunc(x_k)) > tol
        B = d2func(x_k);
        g = dfunc(x_k);
        p_k = dogleg(g, B, delta_k);
        r_k = - (func(x_k) - func(x_k + p_k)) ...
            / ( dot(g, p_k) + 0.5 * dot(p_k, B * p_k) );
        if r_k < 0.25
            delta_k = 0.25 * delta_k;
        else 
            if r_k > 0.75 && norm(p_k) == delta_k
                delta_k = min(2 * delta_k, delta);
            end
        end
        if r_k > n
            x_k = x_k + p_k;
            x_out = [x_out x_k];
        end 
        k = k + 1;
    end
end

