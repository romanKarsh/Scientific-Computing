tol = 10^(-8);
a = 2; b = 1; xp = 1; yp = 1;

for n = 1:4
    if n == 1
        figure(1);
        r = [pi/4; -pi/2];
    elseif n == 3
        figure(2);
        r = [pi/4; pi/2];
    end
    axis([-0.05 2.15 0 2]);
    x = [0 a*cos(r(1,1))];
    y = [0 a*sin(r(1,1))];
    if n == 1 || n == 3
        line(x,y,'Color','red','LineStyle','--');
    else
        line(x,y,'Color','red');
    end
    
    % Second part of the arm
    x = [a*cos(r(1,1)), a*cos(r(1,1))+b*cos(r(1,1)+r(2,1))];
    y = [a*sin(r(1,1)) a*sin(r(1,1))+b*sin(r(1,1)+r(2,1))];
    if n == 1 || n == 3
        line(x,y,'Color','red','LineStyle','--');
    else
        line(x,y,'Color','red');
    end
    if n == 1 || n == 3
        inr = r;
        [r, it, rall, res] = robotarm(a, b, [xp; yp], r, tol, 1000);
        fprintf('For initil angles %15.12f %15.12f\n', inr(1,1), inr(2,1)); 
        fprintf('Calculated angles %15.12f %15.12f\n', r(1,1), r(2,1));
        tem = size(res);
        fprintf('Residuals \n');
        for i = 1:tem(1, 2)
            fprintf('%15.12f ', res(i));
        end
        fprintf('\n');
    end
end