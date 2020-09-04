function p = dogleg(g, B, delta)
    % Assume B is SPD
    p_B = -B\g;
    p_U = - dot(g, g) / dot(g, B * g) * g;
    if norm(p_B) <= delta % the unique minimizer of m is in the trust reg
        p = p_B;
    elseif norm(p_U) >= delta % trust region intersects first path
        p = (delta / norm(p_U) ) * p_U;
    else
        % (4.16) solve quadratic || p_C + (t - 1)(p_B - p_C) ||^2 = delta^2
        % for t - 1. That is A * x^2 + D * x + C
        A = norm(p_B - p_U)^2;
        D = dot(p_B - p_U, p_U);
        C = norm(p_U)^2 - delta^2;
        t = max(roots([A D C])); % positive root
        p = p_U + t * (p_B - p_U);
    end
end

