% function [vf, df] = ff(x)
function [vf, df] = ff(x)

vf = cos(x) - x.^2 / 2 + 1/2;
df = -sin(x) - x;
