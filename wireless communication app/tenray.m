function Ldb =tenray(fc, l, Gl, ray0, varargin)
% ten ray model for narrowband signals (with LoS path):
%   it is assumed that ht = hr


rays =zeros([10,3]);
rays(1,:) = ray0;
switch nargin
    case 5
        rays(2,:) =varargin{1};
    case 6
        rays(2,:) =varargin{1};
        rays(3,:) =varargin{2};
    case 7
        rays(2,:) =varargin{1};
        rays(3,:) =varargin{2};
        rays(4,:) =varargin{3};
    case 8
        rays(2,:) =varargin{1};
        rays(3,:) =varargin{2};
        rays(4,:) =varargin{3};
        rays(5,:) =varargin{4};
    case 9
        rays(2,:) =varargin{1};
        rays(3,:) =varargin{2};
        rays(4,:) =varargin{3};
        rays(5,:) =varargin{4};
        rays(6,:) =varargin{5};
    case 10
        rays(2,:) =varargin{1};
        rays(3,:) =varargin{2};
        rays(4,:) =varargin{3};
        rays(5,:) =varargin{4};
        rays(6,:) =varargin{5};
        rays(7,:) =varargin{6};
    case 11
        rays(2,:) =varargin{1};
        rays(3,:) =varargin{2};
        rays(4,:) =varargin{3};
        rays(5,:) =varargin{4};
        rays(6,:) =varargin{5};
        rays(7,:) =varargin{6};
        rays(8,:) =varargin{7};
        rays(9,:) =varargin{8};
    case 12
        rays(2,:) =varargin{1};
        rays(3,:) =varargin{2};
        rays(4,:) =varargin{3};
        rays(5,:) =varargin{4};
        rays(6,:) =varargin{5};
        rays(7,:) =varargin{6};
        rays(8,:) =varargin{7};
        rays(9,:) =varargin{8};
        rays(10,:)=varargin{9};
    otherwise
        warning('computing only LoS path')
end
    lam = physconst('LightSpeed') / fc;
    xi  =rays(:,1);
    Gxi =rays(:,2);
    Ri  =rays(:,3);
    dphi=2*pi.*(xi -l) ./lam;

    Li  =(lam/4/pi)^2 * abs(sqrt(Gl)/l + Ri.*sqrt(Gxi).*exp(-1i*dphi)./xi).^2;
    
    L =Li(~isnan(Li));

    Ldb =db(L);
    
end
