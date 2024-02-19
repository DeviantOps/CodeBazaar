function syracuse_gen(x, n)
% Cette fonction calcule la suite généralisée de Syracuse de Lester Hill
% à partir du nombre x en utilisant le facteur de multiplication n.

fprintf('Suite de Syracuse généralisée de Lester Hill à partir de %d avec n=%d :\n', x, n);
fprintf('%d ', x);
while x > 1
    if mod(x, 2) == 0 % x est pair
        x = x / 2;
    else % x est impair
        x = n * x + 1;
    end
    fprintf('%d ', x);
end
fprintf('\n');
