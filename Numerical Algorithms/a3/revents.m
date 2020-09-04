function [value, terminal, direction] = revents(t, y, m, l, gamma, A, omega)
yp = pendulum(t, y, m, l, gamma, A, omega);
value(1) = yp(1, 1); % thetha' = 0
terminal(1) = 0; % do not stop the integration
direction(1) = -1; % -1 for decreasing direction only LOCAL MAX (TOP RIGHT)

value(2) = yp(1, 1); % thetha' = 0
terminal(2) = 0; % do not stop the integration
direction(2) = 1; % 1 for increasing direction only LOCAL MIN (TOP LEFT)

value(3) = abs(y(1)) + abs(y(2)) - 10e-8;
terminal(3) = 1; % stop the integration
direction(3) = 0; % if all zeros are to be located (the default)
end

