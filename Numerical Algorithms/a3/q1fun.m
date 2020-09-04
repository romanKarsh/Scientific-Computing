% ------ file q1fun.m ------
% function yp = q1fun(t, y)
% y2’ = -y1 + y3 - 3*exp(-t) + 1;
% y3’ = -y3 + y2 - exp(-t) + 1;
function yp = q1fun(t, y)
yp = y*y/t + y/t;