fprintf("x=%d y=%d k=%d\n", 3, 2, 1);
old_x = 3;
old_y = 2;
x = 3 * old_x + 4 * old_y;
y = 2 * old_x + 3 * old_y;
old_x = x;
old_y = y;
k = 2;
A={'3,2'};
while x ~= 3 || y ~= 2
    fprintf("x=%d y=%d k=%d\n", x, y, k);
    x = rem(3 * old_x + 4 * old_y, 3779);
    y = rem(2 * old_x + 3 * old_y, 3779);
    newstr = strcat(num2str(x), ",", num2str(y));
    if any(strcmp(A,newstr))
        fprintf("STOPPPPPPPPPPP\n");
    end
    A{k} = newstr;
    old_x = x;
    old_y = y;
    k = k + 1;
end
fprintf("x=%d y=%d k=%d\n", x, y, 9999999);