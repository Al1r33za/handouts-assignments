function Ldb =okumura(fc, d, ht, hr, env)
%
%
%

arguments
    fc (1,1) {mustBeGreaterThan(fc, 150e6), mustBeLessThan(fc, 1500e6)} 
    d  (1,:) {mustBeGreaterThan(d, 1000), mustBeLessThan(d, 100000)}
    ht (1,1) {mustBeGreaterThan(ht, 30), mustBeLessThan(ht, 1000)}
    hr (1,1) 
    env {mustBeMember(env, {'urban', 'subrban', 'rural'})} = 'rural'
end

%freespace path loss
L =@(fc, d) 32.45 + 2*db(fc) + 2*db(d);

% median attenuation okumura charts approx:
Amu =@(fc, d) 69.55 + 2.616*db(fc) - 1.382*db(ht);

% Antenna height gain
Ght =2*db(ht/200);
if (3 < hr && hr < 10)
    Ghr =2*db(hr/3);
else
    Ghr =db(hr/3);
end

switch env
    case 'urban'
        GAREA =0;
    case 'suburban'
        GAREA =-10;
    case 'rural'
        GAREA =-20;
    otherwise
        error('Enviroment not defined')
end

Ldb = L(fc, d) + Amu(fc, d) + Ght + Ghr + GAREA;
end
