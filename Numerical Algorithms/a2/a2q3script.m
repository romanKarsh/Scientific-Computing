U = {@(x)x.^5, @(x)(25+x.^2).^(-1), @(x)x.^(11/2)};
Ud = {@(x)5*x.^4, @(x)(-2)*(25*x.^(-0.5)+x.^(3/2)).^(-2), @(x)(11/2)*x.^(9/2)};
bounds = {[0 1], [-1 1], [0 1]};
label = {'u(x) = x^5 in [0, 1]\n', 'u(x) = 1/(1 + 25x^2) in [-1, 1]\n', ...
    'u(x) = x^(11/2) in [0, 1]\n'};
N = [8; 16; 32; 64; 128; 256];
[QuinticMidErr, QuinticIntrErr, QuinticDervErr, ... 
    CubicMidErr, CubicIntrErr, CubicDervErr] = deal(zeros(length(N), 1));
[pcB, pcY, psB, psY, pcderB, pcderY, psderB, psderY] = deal(zeros(1, length(N)-1));
for p = 1:length(U)
    fprintf(label{p});
    a = bounds{p}(1); b = bounds{p}(2); u = U{p}; ud = Ud{p};
    for j = 1:length(N)
        n = N(j);
        x = linspace(a, b, n+1);  % the knots
        tempx = [x(1) (x(1)+x(2))/2 x(2) (x(2)+x(3))/2 x(3:n-1) ...
            (x(n-1)+x(n))/2 x(n) (x(n)+x(n+1))/2 x(n+1)];
        y = u(tempx);  % values used to construct interpolant
        midx = zeros(1, length(x)-1);
        for i = 1:length(x)-1
           midx(i) = (x(i) + x(i+1))/2;
        end
        ths = linspace(a, b, 1000);
        xv = [midx ths];  % evaluation points
        actual_y = u(xv);
        actual_yd = ud(x);
        [estm_y, c] = qntspline(x, y, xv);
        estm_yd = zeros(1, length(x));
        h = x(2) - x(1); % step size
        for i = 1:length(x)
            estm_yd(i) = (1/(24*h)) * (-c(i)-10*c(i+1)+10*c(i+3)+c(i+4));
        end
        d_err = max(abs(estm_yd - actual_yd));
        mid_err = max(abs(estm_y(1:length(x)-1) - actual_y(1:length(x)-1)));
        max_err = max(abs(estm_y(length(x):end) - actual_y(length(x):end)));
        QuinticMidErr(j) = mid_err;
        QuinticIntrErr(j) = max_err;
        QuinticDervErr(j) = d_err;
        % Do the same with cubic spline
        pp = spline(x, u(x));
        [breaks,coefs,l,k,d] = unmkpp(pp);
        new_coefs = coefs * diag([3 2 1 1]); % derivative coeficients
        new_coefs = new_coefs(:, 1:end-1);  % shift over
        dd = mkpp(breaks, new_coefs);
        estm_yd2 = ppval(dd, x);
        d_err2 = max(abs(estm_yd2 - actual_yd));
        estm_y2 = ppval(pp, xv);
        mid_err2 = max(abs(estm_y2(1:length(x)-1) - actual_y(1:length(x)-1)));
        max_err2 = max(abs(estm_y2(length(x):end) - actual_y(length(x):end)));
        CubicMidErr(j) = mid_err2;
        CubicIntrErr(j) = max_err2;
        CubicDervErr(j) = d_err2;
    end
    if p == 2
        for j = 1:length(N)-1
            psB(j) = log2(QuinticIntrErr(j)/QuinticIntrErr(j+1));
            psderB(j) = log2(QuinticDervErr(j)/QuinticDervErr(j+1));
            pcB(j) = log2(CubicIntrErr(j)/CubicIntrErr(j+1));
            pcderB(j) = log2(CubicDervErr(j)/CubicDervErr(j+1));
        end
    elseif p == 3
        for j = 1:length(N)-1
            psY(j) = log2(QuinticIntrErr(j)/QuinticIntrErr(j+1));
            psderY(j) = log2(QuinticDervErr(j)/QuinticDervErr(j+1));
            pcY(j) = log2(CubicIntrErr(j)/CubicIntrErr(j+1));
            pcderY(j) = log2(CubicDervErr(j)/CubicDervErr(j+1));
        end
    end
    disp(table(N, QuinticMidErr, QuinticIntrErr, QuinticDervErr, ...
        CubicMidErr, CubicIntrErr, CubicDervErr))
end
fprintf('Estimating ps\n');
fprintf('Function B: ');
disp(psB);
fprintf('Function Y: ');
disp(psY);

fprintf('Estimating pc\n');
fprintf('Function B: ');
disp(pcB);
fprintf('Function Y: ');
disp(pcY);

fprintf("Estimating ps'\n");
fprintf('Function B: ');
disp(psderB);
fprintf('Function Y: ');
disp(psderY);

fprintf("Estimating pc'\n");
fprintf('Function B: ');
disp(pcderB);
fprintf('Function Y: ');
disp(pcderY);