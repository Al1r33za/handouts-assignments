function [Ldb, L] = freespace(fc, d, Gl)

lam = physconst('LightSpeed') / fc;

L = ((sqrt(Gl)*lam) / (4*pi*d))^2;

Ldb = -db(L);

end