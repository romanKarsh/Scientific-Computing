m = 2;
l = 1;
freq = sqrt(9.81/l); % w
gamma = 2; % y
t0 = 0; tf = 40;  % same for all cases we use this function
y0 = [1, 0];
fprintf('=========================  Part a ===========================\n');
for s = 1:2
    ampl = 2 * (s-1);
    [t, y, te, ye, ie] = runODE(m, l, gamma, ampl, freq, t0, tf, y0);
    
    figure(s);
    subplot(2,2,1)
    plot(t, y(:, 1), 'r-', t, y(:, 2), 'b--');
    xlabel('t'); ylabel('y');
    legend("thetha", "thetha'");
    title("thetha and thetha' versus time for t in [0,trest]")
    axis tight

    subplot(2,2,2)
    cut = length(find(t <= 12));
    plot(t(1:cut), y(1:cut, 1), 'r-', t(1:cut), y(1:cut, 2), 'b--');
    xlabel('t'); ylabel('y');
    legend("thetha", "thetha'");
    title("thetha and thetha' versus time for t in [0,12]")
    axis tight

    subplot(2,2,3)
    h = ones(cut-1, 1);
    for i = 1:cut-1
        h(i, 1) = t(i+1, 1) - t(i, 1);
    end
    plot(t(1:cut-1), h, 'r-');
    xlabel('t'); ylabel('h');
    title("stepsizes versus time for t in [0,12]")
    axis tight

    subplot(2,2,4)
    eve2 = find(ie == 2);  % indexes where event2 occured
    first_ind = eve2(1);
    last_t = te(first_ind);  % value of t when first event2 occured
    amount_t = length(find(t <= last_t)); % num of t before last_t
    xc = zeros(amount_t, 1); yc = zeros(amount_t, 1);
    for i = 1:amount_t
        xc(i, 1) = l * sin(y(i, 1));
        yc(i, 1) = -l * cos(y(i, 1));
    end
    plot(xc, yc, 'o-');
    xline(0);
    title('x versus y')
    axis([-0.85 0.85 -1.1 0.1]);
end       

fprintf('=========================  Part b ===========================\n');
A = [0 1 2 4];
for s = 1:4
    gamma = 2^(s-1); % y
    for q = 1:4
        ampl = A(q);
        runODE(m, l, gamma, ampl, freq, t0, tf, y0);
    end
end

fprintf('=========================  Part c ===========================\n');
gamma = 4; % y GIVEN
answer = getAmp(m, l, freq, gamma, y0(1), y0(1));  % get the A to match gamme
[t, y, ~, ~, ~] = runODE(m, l, gamma, answer, freq, t0, tf, y0);
% see the result
figure(3);
plot(t, y(:, 1), 'r-');
xlabel('t'); ylabel('y');
legend("thetha");
title("thetha with predicted ampl")
axis tight


function [t, y, te, ye, ie] = runODE(m, l, gamma, ampl, freq, t0, tf, y0)
    opt = odeset('events', @(t,y) revents(t, y, m, l, gamma, ampl, freq));
    opt = odeset(opt,'RelTol',10e-4);
    opt = odeset(opt,'AbsTol',10e-8);
    % opt = odeset(opt, 'Stats', 'on'); % to get number of function evaluations
    [t, y, te, ye, ie, stats] = ode45(@(t,y) pendulum(t, y, m, l, gamma, ampl, freq), ...
                                                    [t0, tf], y0, opt);
    trst = t(end);
    nosc = length(find(ie == 1));
    nstp = length(t) - 1;
    nfev = stats(3);
    eve1 = find(ie == 1);  % indexes where event1 occured
    last_ind = eve1(end);
    ul = ye(last_ind, 1);
    vl = ye(last_ind, 2);
    fprintf('gamma  m    l   ampl freq trst nosc nstp  nfev  angle  ang vel\n')
    fprintf('%4.1f %4.1f %4.1f %4.1f %4.1f %6.2f %3d %4d %5d %6.1e %8.1e\n', ...
        gamma, m, l, ampl, freq, trst, nosc, nstp, nfev, ul, vl);
end