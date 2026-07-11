function [Ldb, L] =tworay(fc, d, ht, hr, Ga, Gb,  Gc, Gd, l, R)
%
%

arguments
    fc
    d
    ht
    hr
    Ga
    Gb
    Gc
    Gd
    l
    R (1,1) {mustBeNumeric} = -1
end



lam = physconst('LightSpeed') / fc;
x1x2 =norm(ht+hr, d) - norm(ht-hr, d) + l;
dphi =2*pi*(x1x2-l)/lam;

L =(lam/4/pi)^2 * abs(sqrt(Gl)/l + R*sqrt(Gr)*exp(-1i*dphi)/x1x2)^2;

Ldb = db(L);
end