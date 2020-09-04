% ------ file odefun.m ------
% function yp = odefun(t, y)
% example of a 3 x 3 system of first order ODEs
% y1’ = y2;
% y2’ = -y1 + y3 - 3*exp(-t) + 1;
% y3’ = -y3 + y2 - exp(-t) + 1;
function yp = odefun(t, y)
yp(1, 1) = y(2);
yp(2, 1) = -y(1) + y(3) - 3*exp(-t) + 1;
yp(3, 1) = -y(3) + y(2) - exp(-t) + 1;