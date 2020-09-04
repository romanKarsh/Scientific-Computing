function y = phi(x)
% first range
y(x <= 0) = 0;
% second range
x2 = x(0 < x & x <= 1);
y(0 < x & x <= 1) = x2.^5;
% third range
x3 = x(1 < x & x <= 2);
y(1 < x & x <= 2) = x3.^5 - 6*(x3-1).^5;
% fourth range
x4 = x(2 < x & x <= 3);
y(2 < x & x <= 3) = x4.^5 - 6*(x4-1).^5 + 15*(x4-2).^5;
% fifth range
x5 = x(3 < x & x <= 4);
y(3 < x & x <= 4) = x5.^5 - 6*(x5-1).^5 + 15*(x5-2).^5 - 20*(x5-3).^5;
% sixth range
x6 = x(4 < x & x <= 5);
y(4 < x & x <= 5) = x6.^5 - 6*(x6-1).^5 + 15*(x6-2).^5 - 20*(x6-3).^5 + 15*(x6-4).^5;
% seventh range
x7 = x(5 < x & x < 6);
y(5 < x & x < 6) = x7.^5 - 6*(x7-1).^5 + 15*(x7-2).^5 - 20*(x7-3).^5 + 15*(x7-4).^5 - 6*(x7-5).^5;
% last range
y(x >= 6) = 0;
y = y/120;
