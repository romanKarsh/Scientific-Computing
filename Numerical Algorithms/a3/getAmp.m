function [A] = getAmp(m, l, freq, gamma, init, goal)
if gamma == 0
    A = 0;
    return;
end
ampl = 0.25; % INITIAL GUESS
old_ampl = 1;
while 1  % keep doubling A until max angle is over 'goal'
    [~, overF] = runSim(ampl, m, l, freq, init, gamma, goal);
    % fprintf("A: %4.6f undeF %d overF %d\n", ampl, undeF, overF);
    if overF == 1  % over
        break
    end
    old_ampl = ampl;
    ampl = 2 * ampl;
end
% at this point old_ampl is under and ampl is over. solution is somewhere
% in between them
iter = 1;
% 50 iterations seemed to be enough for most cases. Exit if ampl narrowed
while iter < 50 && abs(ampl - old_ampl) >= 0.0001
    cur_ampl = (old_ampl + ampl)/2;
    [undeF, overF] = runSim(cur_ampl, m, l, freq, init, gamma, goal);
    if undeF == 0 && overF == 0
        break;
    elseif overF == 1  % we were over
        ampl = cur_ampl;
    else  % we were under
        old_ampl = cur_ampl;
    end
    iter = iter + 1;
    % fprintf("A: %4.6f undeF %d overF %d\n", cur_ampl, undeF, overF);
end
A = cur_ampl;
end

% helper function to run the pendulum swinging simulation
% returns under and over indicators for the maximum angle
function [undeF, overF] = runSim(amp, m, l, freq, init, gamma, goal)
    t0 = 0; tf = 40;
    y0 = [init, 0];
    opt = odeset('events', @(t,y) revents(t, y, m, l, gamma, amp, freq));
    opt = odeset(opt,'RelTol',10e-4);
    opt = odeset(opt,'AbsTol',10e-8);
    [~, ~, ~, ye, ie] = ode45(@(t,y) pendulum(t, y, m, l, gamma, amp, freq), ...
                                                    [t0, tf], y0, opt);
    eve1 = find(ie == 1);
    eve2 = find(ie == 2);
    undeF = 0; % are the max osc under y0(1) -- Should inc A
    overF = 0; % are the max osc over y0(1) -- Should dec A even if under
    for i = 5:length(eve2)  % skip the first 5 
        thetha_m =  ye(eve2(i), 1);
        if abs(thetha_m) - goal <= 0.05
           undeF = 1; 
        end
        if abs(thetha_m) - goal >= 0.05
           overF = 1; 
        end
    end
    for i = 5:length(eve1)  % skip the first 5 
        thetha_m =  ye(eve1(i), 1);
        if abs(thetha_m) - goal <= 0.05
           undeF = 1; 
        end
        if abs(thetha_m) - goal >= 0.05
           overF = 1; 
        end
    end    
end
