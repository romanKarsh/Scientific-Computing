function a = linesearch(func, dfunc, p, x_k, a_max, c1, c2)
% Algorithm 3.5 of the textbook
% phi(a) = f(x_k + a * p)  and dphi(a) = Vf(x_k + a*p)^T p
phi0 = func(x_k);
dphi0 = dot(dfunc(x_k), p);
a_past = 0; a_i = a_max/2; phi_past=0; % past phi(a)
i = 1;
while 1
    phi_ai = func(x_k + a_i * p);
    dphi_ai = dot(dfunc(x_k + a_i*p), p);
    if (phi_ai > phi0 + c1*a_i*dphi0) || (i > 1 && phi_ai >= phi_past)
        a = zoom(a_past, a_i, func, dfunc, p, x_k, c1, c2);
        return;
    end
    if abs(dphi_ai) <= -c2 * dphi0
        a = a_i;
        return;
    end
    if dphi_ai >= 0
        a = zoom(a_i, a_past, func, dfunc, p, x_k, c1, c2);
    end
    a_past = a_i;
    phi_past = phi_ai;
    a_i = (a_i + a_max)/2;
    i = i + 1;
end
end

function a_out = zoom(a_lo, a_hi, func, dfunc, p, x_k, c1, c2)
% Algorithm 3.6 of the textbook
phi0 = func(x_k);
philo = func(x_k + a_lo * p);
dphi0 = dot(dfunc(x_k), p);
while 1
    a_j = (a_lo + a_hi)/2;
    phi_aj = func(x_k + a_j * p);
    if phi_aj > phi0 + c1*a_j*dphi0 || phi_aj >= philo
        a_hi = a_j;
    else
        dphi_aj = dot(dfunc(x_k + a_j*p), p);
        if abs(dphi_aj) <= -c2*dphi0
            a_out = a_j;
            return;
        end
        if dphi_aj * (a_hi - a_lo) >= 0
            a_hi = a_lo;
        end
        a_lo = a_j;
    end
end
end

