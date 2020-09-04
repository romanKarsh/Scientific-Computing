a = 1/4; b = 4;
xe = linspace(a, b, 1000);
ye = sqrt(xe);

disp(['interval (' num2str(a) ',' num2str(b), ')'])
disp('  n    err poly   err lin_spl')
for nn = 1:6
    n = 2^nn;
    xi = linspace(a, b, n+1);
    yi = sqrt(xi);
    yp = polyval(polyfit(xi, yi, n), xe);
    yl = interp1(xi, yi, xe, 'linear');
    ep = max(abs(ye-yp));
    el = max(abs(ye-yl));
    fprintf('%3d %12.3e %12.3e\n', n, ep, el);
end

fprintf('\n')
disp(['interval (' num2str(a) ',' num2str(b), ')'])
disp('  n   err lin_spl err cub_spl')
for nn = 4:9
    n = 2^nn;
    xi = linspace(a, b, n+1);
    yi = sqrt(xi);
    yl = interp1(xi, yi, xe, 'linear');
    yc = spline(xi, yi, xe); % use cubic spline interpolation (not-a-knot)
    el(nn) = max(abs(ye-yl));
    ec(nn) = max(abs(ye-yc));
    fprintf('%3d %12.3e %12.3e ', n, el(nn), ec(nn));
    if (nn > 4)
        fprintf('%6.1f %6.1f\n', log(el(nn-1)/el(nn))/log(2), ...
                                 log(ec(nn-1)/ec(nn))/log(2));
    else fprintf('\n'); end
end

a = 0; b = 4;
xe = linspace(a, b, 1000);
ye = sqrt(xe);

fprintf('\n')
disp(['interval (' num2str(a) ',' num2str(b), ')'])
disp('  n   err lin_spl err cub_spl')
for nn = 4:9
    n = 2^nn;
    xi = linspace(a, b, n+1);
    yi = sqrt(xi);
    yl = interp1(xi, yi, xe, 'linear');
    yc = spline(xi, yi, xe); % use cubic spline interpolation (not-a-knot)
    el(nn) = max(abs(ye-yl));
    ec(nn) = max(abs(ye-yc));
    fprintf('%3d %12.3e %12.3e ', n, el(nn), ec(nn));
    if (nn > 4) 
        fprintf('%6.1f %6.1f\n', log(el(nn-1)/el(nn))/log(2), ... 
                                 log(ec(nn-1)/ec(nn))/log(2));
    else fprintf('\n'); end
end
