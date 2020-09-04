% ============================  Part c ==============================
m = 2;
l = 1;
freq = sqrt(9.81/l); % w
gamma = 4; % y GIVEN
y0 = [1 0];
myA = getAmp(m, l, freq, gamma, y0(1));

% See the result for calculated A
t0 = 0; tf = 40;
opt = odeset('events', @(t,y) revents(t, y, m, l, gamma, myA, freq));
opt = odeset(opt,'RelTol',10e-4);
opt = odeset(opt,'AbsTol',10e-8);
% opt = odeset(opt, 'Stats', 'on'); % to get number of function evaluations
[t, y, te, ye, ie, stats] = ode45(@(t,y) pendulum(t, y, m, l, gamma, myA, freq), ...
                                                [t0, tf], y0, opt);
plot(t, y(:, 1), 'r-', t, y(:, 2), 'b--');
xlabel('t'); ylabel('y');
legend("thetha", "thetha'");
title("thetha and thetha' versus time for t in [0,trest]")
axis tight

