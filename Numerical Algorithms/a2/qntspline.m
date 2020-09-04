function [yv, dof] = qntspline(x, y, xv)
n = length(x) - 1; % x has n+1 (equidistant) knots
h = x(2) - x(1); % step size of the knots
diag = 2112 * ones(n+5, 1);
sub1 = 832 * ones(n+5, 1);
sub2 = 32 * ones(n+5, 1);
A = spdiags([sub2 sub1 diag sub1 sub2], [-2 -1 0 1 2], n+5, n+5);
% set up the upper left corner of matrix A
A(1,1) = 32; A(1, 2) = 832; A(1, 3) = 2112; A(1, 4) = 832; A(1, 5) = 32;
A(2,1) = 1; A(2, 2) = 237; A(2, 3) = 1682; A(2, 4) = 1682; A(2, 5) = 237; A(2, 6) = 1;
A(3,2) = 32; A(3, 3) = 832; A(3, 4) = 2112; A(3, 5) = 832; A(3, 6) = 32;
A(4,2) = 1; A(4, 3) = 237; A(4, 4) = 1682; A(4, 5) = 1682; A(4, 6) = 237; A(4, 7) = 1;
A(3, 1) = 0; % spdiags sets this to 32!!!! DONT WANT THIS
% set up the lower right corner of matrix A
A(n+5,n+5) = 32; A(n+5, n+4) = 832; A(n+5, n+3) = 2112; A(n+5, n+2) = 832; A(n+5, n+1) = 32;
A(n+4,n+5) = 1; A(n+4, n+4) = 237; A(n+4, n+3) = 1682; A(n+4, n+2) = 1682; A(n+4, n+1) = 237; A(n+4, n) = 1;
A(n+3,n+4) = 32; A(n+3, n+3) = 832; A(n+3, n+2) = 2112; A(n+3, n+1) = 832; A(n+3, n) = 32;
A(n+2,n+4) = 1; A(n+2, n+3) = 237; A(n+2, n+2) = 1682; A(n+2, n+1) = 1682; A(n+2, n) = 237; A(n+2, n-1) = 1;
A(n+3, n+5) = 0; % spdiags sets this to 32!!!! DONT WANT THIS

c = 3840 * (A\y'); % solve for the coefficients
yv = zeros(1, length(xv)); % compute s(x)
for i = -2:n+2
    yv = yv + c(i+3) * phi((xv-x(1))/h - i + 3);
end
dof = c;
