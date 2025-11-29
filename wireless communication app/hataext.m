function Ldb =hataext(fc, d, ht, hr, ismetropol)
%
%
%

arguments
    fc (1,1) {mustBeInRange(fc, 1500, 2000)}
    d  (1,:) {mustBeInRange( d, 1000, 20000)}
    ht (1,1) {mustBeInRange(ht, 30, 200)}
    hr (1,1) {mustBeInRange(hr,  1, 10)}
    ismetropol (1,1) {mustBeNumericOrLogical, mustBeInRange(ismetropol, 0, 1)} = false
end

if ismetropol
    C =3; %db
else
    C =0;
end

%  correction factor
ahr =(1.1*log10(fc) - 0.7)*hr - (1.56*log10(fc) - 0.8);

% COST-231
Ldb = 46.3 + 33.9*log10(fc) - 13.82*log10(ht) - ahr + (44.9 - 6.55*log10(hr)).*log10(d) + C;
end
