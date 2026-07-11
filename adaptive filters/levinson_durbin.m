% levison durbin algorithm
function [A, J, k] = levinson_durbin(rss, pmax)

rss0 = rss(1);
rss  = rss(2:pmax+1)';              % 
A      = zeros(pmax);               % A coeff matrix
k      = zeros(1, pmax);            % reflection coeff
J      = zeros(1, pmax);            % error in each order
%----------------------------
% INITILIZATION
%----------------------------
k(1)   = rss(1)/rss0;             % k(1) = r(1)/r(0)
A(1,1) = k(1);                    % a(1,1) = A(1,1) = k(1)
J(1) = (1 - k(1)^2)*rss0;                      % J_p = r_s(0)
%----------------------------
for i=2:pmax
    
    PsiBT = flip(rss(1:i-1));

    k(i) = ( rss(i) - ( PsiBT * A(1:i-1, i-1) ) )/J(i-1);
    
    A(1:i, i) = A(1:i, i-1) - k(i) * [flip(A(1:i-1, i-1)); -1];

    J(i) = (1-k(i)^2) * J(i-1);
end

end