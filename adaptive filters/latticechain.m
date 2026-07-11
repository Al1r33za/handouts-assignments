% lattice of order P
function [fm, bm] = latticechain(f0, b0, k)
fm = zeros(numel(k)+1, numel(f0));
bm = zeros(numel(k)+1, numel(b0));
fm(1,:) =f0;
bm(1,:) =b0;

f =f0;
b =b0;

for p =1:numel(k)
    [f, b] = lattice_struct(k(p), f, b);

    fm(p+1,:) = f;
    bm(p+1,:) = b;
end