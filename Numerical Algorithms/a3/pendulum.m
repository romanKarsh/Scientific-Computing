function yp = pendulum(t, y, m, l, gamma, A, omega)
yp(1, 1) = y(2);
yp(2, 1) = (A*cos(omega * t) - gamma*y(2))/(m*l^2) - 9.81/l * sin(y(1));
end

