% the only local minimizer of this rosenbrok function is [1, 1]'

stp_d = steepestDescent(@rosenbrock, @rosenbrockDer, [1, 1], [1.2, 1.2]', 1, 0, 10^-3, 1, 100);
min_nt = newton(@rosenbrock, @rosenbrockDer, @rosenbrockDer2, [1, 1], [1.2, 1.2]', 1, 0, 10^-3, 1, 1);
fin = BFGS(@rosenbrock, @rosenbrockDer, [1, 1], [1.2, 1.2]', 2, 50, 10^-3, 1, 1);

stp_d = steepestDescent(@rosenbrock, @rosenbrockDer, [1, 1], [-1.2, 1]', 1, 0, 10^-3, 1, 100);
min_nt = newton(@rosenbrock, @rosenbrockDer, @rosenbrockDer2, [1, 1], [-1.2, 1]', 1, 0, 10^-3, 1, 1);
fin = BFGS(@rosenbrock, @rosenbrockDer, [1, 1], [-1.2, 1]', 2, 50, 10^-3, 1, 1);

% contours of the rosenbrock function
[X, Y] = meshgrid(-4:0.1:4, -4:0.1:4); 
Z = 100 * (Y - X.^2).^2 + (1 - X).^2;
contour(X,Y,Z,40)

function out = rosenbrock(x)
% computes the Rosenbrock function (2.22) A2
% rosenbrock([1, 1]') -> should be 0
out = 100 * (x(2) - x(1).^2).^2 + (1 - x(1)).^2;
end

function x_der = rosenbrockDer(x)
% computes the gradient of Rosenbrock (from 2.1 on page27 of textbook) A2
% rosenbrockDer([1, 1]') -> should be [0, 0]
% rosenbrockDer([1, 2]') -> [-400, 200]
x_der(1, 1) = 400 * x(1) * (x(1)^2 - x(2)) + 2 * (x(1) - 1);
x_der(2, 1) = 200 * (x(2) - x(1)^2);
end

function x_der2 = rosenbrockDer2(x)
% computes the hessian of Rosenbrock (from 2.1 on page27 of textbook) A2
% rosenbrockDer2([1, 1]') -> should be [802, -400; -400, 200]
x_der2(1, 1) = 400 * (3 * x(1)^2 - x(2)) + 2;
x_der2(1, 2) = - 400 * x(1);
x_der2(2, 1) = - 400 * x(1);
x_der2(2, 2) = 200;
end
