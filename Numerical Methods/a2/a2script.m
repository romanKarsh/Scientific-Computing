t = [];
%condmat = [];
%topForces = []; % matrix where each column has the top member forces for each n
%digForces = []; % matrix where each column has the diagonal member forces for each n
for nn = 1:4
	n=2^nn; % no. of top horizontal members
	p=[0.5:n+1]'/(n+1); 
	W = 10000*p.*p.*(1-p)/(n+1); % weights
	N=4*(n+1)+1; ni(nn) = N; % no. of unknowns
	A=sparse(N, N);
	b=zeros(N, 1); b(4:4:N-1, 1) = -W; % right-hand side vector
	a=sqrt(2)/2;
    % leftmost vertical member
	A(1, 1:5) = [a  0  0 -1 -a];
	A(2, 1:5) = [a  0  1  0  a];
	A(3, 1:6) = [0  1  0  0  0 -1];
	A(4, 1:4) = [0  0  1  0];
	for k = 2:2:n-1 % go over pairs of interior vertical members
    % vertical member with diagonal beams at the bottom joint
		r=4*k-3;
		A(r, r-1:r+3)   = [1  0  0  0 -1];
		A(r+1, r+1:r+2) = [0  1];
		A(r+2, r:r+5)   = [a  1  0  0 -a -1];
		A(r+3, r:r+4)   = [a  0  1  0  a];
    % vertical member with diagonal beams at the top joint
		% fill-in the matrix entries
		A(r+4, r+3:r+8) = [1  a  0  0 -1 -a];
		A(r+5, r+4:r+8) = [a  0  1  0  a];
		A(r+6, r+5:r+9) = [1  0  0  0 -1];
		A(r+7, r+6:r+7) = [1  0];
		% sparsity patterns, plots, etc
	end
    % two rightmost vertical members
	% fill-in the matrix entries
	A(N-8, N-9:N-4) = [1  0  0  0 -1  0];
	A(N-7, N-8:N-3) = [0  0  1  0  0  0];
	A(N-6, N-8:N-2) = [a  1  0  0 -a -1  0];
	A(N-5, N-8:N-1) = [a  0  1  0  a  0  0  0];
	A(N-4, N-5:N)   = [1  a  0  0  0 -a];
	A(N-3, N-4:N)   = [a  0  1  0  a];
	A(N-2, N-3:N)   = [1  0 -1  0];
 	A(N-1, N-2:N)   = [1  0  0];
    % rightmost joint
	% fill-in the matrix entries
	A(N, N-1:N) = [1  a];
	% solve system, output, plots, etc
	% A % to test if the matrix is right
	tt = A\b; t(1:N, nn) = tt;
	maxComp = max(tt);
	minComp = min(tt);
	absCo = abs(minComp);
	cond = condest(A);
	topAbs = 0;
	for i = 4:4:N-4
        %topForces(i/4, nn) = tt(i);
		if abs(tt(i)) > abs(topAbs)
			topAbs = abs(tt(i));
		end
	end
	digAbs = 0;
	for i = 1:4:N
        %digForces((i+3)/4, nn) = tt(i);
		if abs(tt(i)) > abs(digAbs)
			digAbs = abs(tt(i));
		end
    end
	%tt
	%n
    %condmat(nn) = cond; % to check condition number of A for each n
    %numnotzeros = nnz(A) % to check the number of nonzero entries
	[L, U, P] = lu(A); % to check upper adn lower and total bandwidth of L U
    figure(n)
    spy(P)
	%[lowerU, upperU] = bandwidth(U)
	%[lowerL, upperL] = bandwidth(L)
	%[lower, upper] = bandwidth(A) % get the bandwidth of A
	fprintf('%3d %9.2f %9.2f %9.2f %9.2f %8.2f\n', n, maxComp, minComp, digAbs, topAbs, cond);
	fprintf('\n');
	if n == 69
		figure(1);
		[L, U, P] = lu(A);
		subplot(2, 2, 1);
		spy(A);
		title('Plot of A');
		subplot(2, 2, 2);
		spy(L);
		title('Plot of L');
		subplot(2, 2, 3);
		spy(U);
		title('Plot of U');
		subplot(2, 2, 4);
		spy(P);
		title('Plot of P');
	end
	if n == 16
		%figure(2);
		%plot([4:4:N-2], tt(4:4:N-2), 'r-', ...   
        %     [3:4:N-2], tt(3:4:N-2), 'g--', ...
		%     [1:2:N], tt(1:2:N), 'b-.', ...
		%     [2:4:N N-1], [tt(2:4:N); tt(N-1)], 'k:');
        %title('n = 16 plot of the four lines');
	end
end
%topForces
%digForces
%condmat
%figure(4);
%plot(1:4, condmat);
%figure(5);
%plot([1:62], digForces(1:62, 6:6));
%figure(3);
%plot([4:4:ni(1)-5]/ni(1), t(4:4:ni(1)-5, 1), 'r-', ...
%    [4:4:ni(2)-5]/ni(2), t(4:4:ni(2)-5, 2), 'g--', ...
%    [4:4:ni(3)-5]/ni(3), t(4:4:ni(3)-5, 3), 'b-.', ...
%    [4:4:ni(4)-5]/ni(4), t(4:4:ni(4)-5, 4), 'k:');
%title('plot of top horizontal members (all n)');



%  2    731.11   -516.98    731.11    648.15    22.14

%  4    840.00   -885.00    708.52    840.00    37.46

%  8   1402.68  -1393.18    702.18   1402.68    93.54

% 16   2468.48  -2428.38    702.54   2468.48   267.93


