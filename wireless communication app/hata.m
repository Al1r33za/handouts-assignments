function Ldb =hata(fc, d, ht, hr, env)
%
%
%

arguments
    fc (1,1) {mustBeGreaterThan(fc, 150e6), mustBeLessThan(fc, 1500e6)}
    d  (1,:)
    ht (1,1)
    hr (1,1)
    env {mustBeMember(env, {'urban', 'suburban', 'rural'})} = 'urban'
end

if fc <= 300 
    ahr =8.29*(log10(1.54*hr))^2 - 1.1; % hr correction factor for mid-sized cities
else
    ahr =3.2*(log10(11.75*hr))^2 - 4.97;
end

% urban pass loss

Lurban =69.5 + 26.2*log10(fc) + 13.8*log10(ht) - ahr + (44.9 - 6.55*log10(ht)).*log10(d);

switch env
    case 'urban'
        Ldb =Lurban;
    case 'suburban'
        Ldb =Lurban - 2*(log10(fc/28))^2 - 5.4;
    case 'rural'
        Ldb =Lurban - 4.78*(log10(fc))^2 + 18.33*log10(fc) - 49.94;
    otherwise
        error('Enviroment not defined')
end

end