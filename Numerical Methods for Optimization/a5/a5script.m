% contours of the rosenbrock function
xs = trustRegion(@rosenbrock, @rosenbrockDer, @rosenbrockDer2, [1.5, 1.2]', 100, 0.01, 1/8, 10^-3);

figure(1);
[X, Y] = meshgrid(0.8:0.001:1.6, 0.8:0.001:1.6); 
Z = 100 * (Y - X.^2).^2 + (1 - X).^2;
contour(X,Y,Z,40); hold on
scatter(xs(1, :), xs(2, :),[],'k')
scatter(1, 1,[],'r')


xs = trustRegion(@rosenbrock, @rosenbrockDer, @rosenbrockDer2, [-1.2, 1]', 100, 0.01, 1/8, 10^-3);

figure(2);
[X, Y] = meshgrid(-1.5:0.001:1.6, -0.1:0.001:1.6); 
Z = 100 * (Y - X.^2).^2 + (1 - X).^2;
contour(X,Y,Z,40); hold on
scatter(xs(1, :), xs(2, :),[],'k')
scatter(1, 1,[],'r')

%{
n = 100;
ind = [20,40,60,94]; %points to plot
xy = randi([10 20],n,2);
contourf(peaks);hold on
scatter(xy(ind,1),xy(ind,2),[],'k')
% scatter([1, 2], [3, 2],[],'k')
%}

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