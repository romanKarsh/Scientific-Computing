A = ones(3, 3);
A(1, 1)=-2; A(2, 2)=-2; A(3, 3)=-2;
A(3, 1)=0; A(1, 3)=0;
x0 = [1 0 0]';
% vecnorm(x0, 1) is the same as x(1) + x(2) + x(3)
y1 = A*x0;
lam1 = vecnorm(y1, 1);
if y1(1) * x0(1) < 0
    lam1 = -1 * lam1;
end
x1 = y1/lam1;
y2 = A*x1;
lam2 = vecnorm(y2, 1);
if y2(1) * x1(1) < 0
    lam2 = -1 * lam2;
end
x2 = y2/lam2;
 
fprintf('power lambda1 %4.5f\n', lam1);
x1
fprintf('power lambda2 %4.5f\n', lam2);
x2
e = eig(A);
fprintf('lambda1 - power lambda2 %4.5f\n', e(1)-lam2);

fprintf('=================== part b ===================\n');

y1 = A\x0;
u = vecnorm(y1, 1);
if y1(1) * x0(1) < 0
    u = -1 * u;
end
x1 = y1/u;
lam1 = 1/u; 
% found it by the fact that evals of A-1 are recipricals of evals of A
% the smallest eval of A, is the largest eval of A-1 since (1/ ..)
fprintf('power u1 %4.5f\n', u);
x1
fprintf('lambda3 - power lambda1 %4.5f\n', e(3)-lam1);