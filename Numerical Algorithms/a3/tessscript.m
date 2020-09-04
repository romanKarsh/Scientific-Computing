% t0 = 1; tf = 15;
% y0 = -2;
% [t, y] = ode45(@q1fun, [t0 tf], y0);
t0 = 0; tf = 5;
y0 = 0;
[t, y] = ode45(@funMinMax, [t0, tf], y0);

figure(1);
plot(t, y, 'r-')
xlabel('t'); ylabel('y')
legend('first func')
axis tight

opt = odeset('events', @myevents);
[t, y, te, ye, ie] = ode45(@funMinMax, [t0 tf], y0, opt);
ie1 = find(ie == 1); ie2 = find(ie == 2);
figure(2);
plot(t, y, 'r-', te(ie1), ye(ie1), 'k^', te(ie2), ye(ie2), 'kv');

% ------ file myevents.m ------
% function [value, terminal, direction] = myevents(t,y)
% Locate the time when yp_1 or y_2 become 0, separately for
% the cases of increasing and decreasing directions.
function [value, terminal, direction] = myevents(t, y)
yp = funMinMax(t, y); % if we need yp values
value(1) = yp(1, 1); % same as y(2, 1); Detect yp_1=0 or y_2=0
terminal(1) = 0; % do not stop the integration
%terminal(1) = 1; % stop the integration
direction(1) = -1; % -1 for decreasing direction only LOCAL MAX
value(2) = yp(1, 1); % same as y(2, 1); Detect yp_1=0 or y_2=0
terminal(2) = 0; % do not stop the integration
direction(2) = 1; % 1 for increasing direction only LOCAL MIN
end