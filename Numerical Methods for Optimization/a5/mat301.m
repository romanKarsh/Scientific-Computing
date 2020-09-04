% clc to clear commands
%{
fprintf("orders in U(200)\n");
fprintf("a=%d |a|=%d\n", 1, orderUn(200, 1));
fprintf("a=%d |a|=%d\n", 7, orderUn(200, 7));
fprintf("a=%d |a|=%d\n", 43, orderUn(200, 43));
fprintf("a=%d |a|=%d\n", 49, orderUn(200, 49));
fprintf("a=%d |a|=%d\n", 51, orderUn(200, 51));
fprintf("a=%d |a|=%d\n", 57, orderUn(200, 57));
fprintf("a=%d |a|=%d\n", 93, orderUn(200, 93));
fprintf("a=%d |a|=%d\n", 99, orderUn(200, 99));
fprintf("a=%d |a|=%d\n", 101, orderUn(200, 101));
fprintf("a=%d |a|=%d\n", 107, orderUn(200, 107));
fprintf("a=%d |a|=%d\n", 143, orderUn(200, 143));
fprintf("a=%d |a|=%d\n", 149, orderUn(200, 149));
fprintf("a=%d |a|=%d\n", 151, orderUn(200, 151));
fprintf("a=%d |a|=%d\n", 157, orderUn(200, 157));
fprintf("a=%d |a|=%d\n", 193, orderUn(200, 193));
fprintf("a=%d |a|=%d\n", 199, orderUn(200, 199));
%}

%{
fprintf('The cyclic group is: [');
fprintf(' %g ', generatorUn(200, 7));
fprintf(']\n');
fprintf('The cyclic group is: [');
fprintf(' %g ', generatorUn(200, 51));
fprintf(']\n');
fprintf('The cyclic group is: [');
fprintf(' %g ', generatorUn(200, 199));
fprintf(']\n');

fprintf("%d\n", orderZn(64, 8));

fprintf('The cyclic group is: [');
fprintf(' %g ', generatorZn(64, 8));
fprintf(']\n');
%}
%{
fprintf('The cyclic group is: [');
fprintf(' %g ', generatorZn(3553, 17));
fprintf(']\n');
fprintf('The cyclic group is: [');
fprintf(' %g ', generatorZn(3553, 11));
fprintf(']\n');
%}
% generatorManyZn([22, 22], [1, 11])

% fprintf('The cyclic group is: [');
% fprintf(' %g ', generatorUn(14, 3));
% fprintf(']\n');

%{
% doing stuff with the U(100) group
u100 = listUn(100);
fprintf('The Un group is: [');
fprintf(' %g ', u100);
fprintf(']\n');
fprintf('Length is %d\n', length(u100));
ords = zeros(1, length(u100));
for i = 1:length(u100)
    ords(i) = orderUn(100, u100(i));
end
fprintf('The orders of Un group is: [');
fprintf(' %g ', ords);
fprintf(']\n');
%}

infoUn(52);





function [] = infoUn(n)
% Multiplicative group of integers modulo n
% doing stuff with the U(n) group
u100 = listUn(n);
fprintf('The Un group is: [');
fprintf(' %g ', u100);
fprintf(']\n');
fprintf('Length is %d\n', length(u100));
ords = zeros(1, length(u100));
sixc = 0;
for i = 1:length(u100)
    ords(i) = orderUn(n, u100(i));
    if orderUn(n, u100(i)) == 2
        sixc = sixc + 1;
    end
end
fprintf('The orders of Un group is: [');
fprintf(' %g ', ords);
fprintf(']\n');
fprintf('%d\n', sixc);
end


function ord = orderUn(n, a)
    if a == 1
        ord = 1;
        return;
    end
    ord = 2;
    pr = a;
    while rem(pr*a, n) ~= 1
        pr = rem(pr*a, n);
        ord = ord + 1;
    end
end

function grp = generatorUn(n, a)
    if a == 1
        grp = 1;
        return;
    end
    grp = [1, a];
    pr = a;
    while rem(pr*a, n) ~= 1
        pr = rem(pr*a, n);
        grp = [grp, pr];
    end
end


function ord = orderZn(n, a)
    if a == 0
        ord = 1;
        return;
    end
    ord = 2;
    pr = a;
    while rem(pr + a, n) ~= 0
        pr = rem(pr + a, n);
        ord = ord + 1;
    end
end

function grp = generatorZn(n, a)
    if a == 0
        grp = [0];
        return;
    end
    grp = [0, a];
    pr = a;
    while rem(pr + a, n) ~= 0
        pr = rem(pr + a, n);
        grp = [grp, pr];
    end
end

function un = listUn(n)
    un = [];
    for i = 1:n-1
       if gcd(i, n) == 1
          un = [un i]; 
       end
    end
end

function grp = generatorManyZn(ns, a)
    m = length(ns);
    grp = [zeros(m, 1), a'];
    pr = a;
    while sum(rem(pr + a, ns)) ~= 0
        pr = rem(pr + a, ns);
        grp = [grp, pr'];
    end
end