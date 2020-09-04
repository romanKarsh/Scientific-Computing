t = [];
for nn = 1:7
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
		if abs(tt(i)) > abs(topAbs)
			topAbs = tt(i);
		end
	end
	digAbs = 0;
	for i = 1:2:N
		if abs(tt(i)) > abs(digAbs)
			digAbs = tt(i);
		end
	end
	%tt
	fprintf('%3d %9.2f %9.2f %9.2f %9.2f %8.2f\n', n, maxComp, minComp, digAbs, topAbs, cond);
	fprintf('\n');
end