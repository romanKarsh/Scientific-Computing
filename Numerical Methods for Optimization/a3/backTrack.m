function a_k = backTrack(func, p, c, a_0, dir, df_k, x_k, f_k)
% Algorithm 3.1 (Backtracking Line Search).
a_k = a_0;
while func(x_k + a_k * dir) > f_k + c * a_k * dot(df_k, dir)
    a_k = p * a_k;
end
end

