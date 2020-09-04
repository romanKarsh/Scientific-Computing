t = [0 10 20 30 40 50];
C = [319.36 329.92 344.32 358.56 377.23 398.29];
plin = polyfit(t, C, 1);
pqua = polyfit(t, C, 2);
pcub = polyfit(t, C, 3);

tt = [60 70 80];
pred_lin = polyval(plin, tt);
pred_qua =  polyval(pqua, tt);
pred_cub =  polyval(pcub, tt);
fprintf('Linear model\n');
fprintf('%4.5f + %4.5f*t\n', plin(2), plin(1));
fprintf('t=%d       t=%d       t=%d\n', tt(1), tt(2), tt(3));
fprintf('C=%4.2f  C=%4.2f  C=%4.2f\n\n', pred_lin(1), pred_lin(2), pred_lin(3));
fprintf('Quadratic model\n');
fprintf('%4.5f + %4.5f*t + %4.5f*t^2\n', pqua(3), pqua(2), pqua(1));
fprintf('t=%d       t=%d       t=%d\n', tt(1), tt(2), tt(3));
fprintf('C=%4.2f  C=%4.2f  C=%4.2f\n\n', pred_qua(1), pred_qua(2), pred_qua(3));
fprintf('Cubic model\n');
fprintf('%4.5f + %4.5f*t + %4.5f*t^2 + %4.5f*t^3\n', ... 
    pcub(4), pcub(3), pcub(2), pcub(1));
fprintf('t=%d       t=%d       t=%d\n', tt(1), tt(2), tt(3));
fprintf('C=%4.2f  C=%4.2f  C=%4.2f\n', pred_cub(1), pred_cub(2), pred_cub(3));

scatter(t, C, '*')
hold on
plot([t tt], polyval(plin, [t tt]), 'o-', [t tt], polyval(pqua, [t tt]),...
    'o--', [t tt], polyval(pcub, [t tt]), 'o-.');
legend('Actual', 'Linear', 'Quadratic', 'Cubic', 'Location','northwest')
xlabel('t'); ylabel('y');
title("CO2 concentrations versus 10 year t for 3 different models")
hold off

A = [ones(6, 1) t'];
b = C';
x = (A'*A)\(A'*b);
