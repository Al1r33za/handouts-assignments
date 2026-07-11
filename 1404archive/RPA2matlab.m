%% ---------- Part (a): Poisson Process ----------
clear; clc; close all;

lambda = 0.1;           % Rate (events/sec)
Tmax = 1000;            % Total time
dt = 0.1;               % Time step
t = 0:dt:Tmax;

% Simulate Poisson process using exponential interarrival times
N = zeros(size(t));
epoch = 0; 
i = 1;

while epoch < Tmax
    epoch = epoch + exprnd(1/lambda);   % Exponential interarrival
    if epoch <= Tmax
        N(t >= epoch) = N(t >= epoch) + 1;
    end
end

figure; plot(t, N, 'LineWidth', 1.5);
title('Poisson Process N(t) with \lambda = 0.1'); xlabel('Time (s)'); ylabel('N(t)'); grid on;

% --- Distribution of N(t+tau) - N(t)
taus = [1 5 10 50 100 200];
figure;
for k = 1:length(taus)
    tau = taus(k);
    idx = randi(length(t)-round(tau/dt), [1 1000]);
    X = N(idx + round(tau/dt)) - N(idx);
    subplot(2,3,k);
    histogram(X); title(['N(t-\tau) - N(t), \tau = ' num2str(tau)]);
    xlabel('Counts'); ylabel('Frequency');
end
%% ---------- Part (b): Gaussian Random Process ----------
clear; clc; close all;

sigma2 = 0.05; alpha = 2;
Tmax = 10; dt = 0.01; t = 0:dt:Tmax;
Nreal = 5;                     % number of realizations

% Generate process using filter of correlated noise
X = zeros(Nreal, length(t));
for i = 1:Nreal
    w = sqrt(sigma2)*randn(1,length(t));   % white noise
    X(i,:) = filter(exp(-alpha*dt), 1, w);
    figure(1); plot(t, X(i,:));hold on; 
end
title('Gaussian Process Realizations'); xlabel('Time'); ylabel('X(t)');

% Estimate mean
m_est = mean(X,1);
figure; plot(t, m_est); title('Estimated Mean'); xlabel('Time'); ylabel('Mean');

% Autocorrelation
[R_emp, tau] = xcorr(X(1,:), 'biased'); %xcorr = cross correlation
figure; plot(tau*dt, R_emp); title('Empirical Autocorrelation'); xlabel('\tau');

% Theoretical Autocorrelation
tau_theory = -5:0.01:5;
R_theory = sigma2*exp(-alpha*abs(tau_theory));
hold on; plot(tau_theory, R_theory, 'r--','LineWidth',1.5);
legend('Empirical', 'Theory');
%% ---------- Part (c): White Noise ----------
clear; clc; close all;

sigma2 = 0.1;
N = 10000;
W = sqrt(sigma2)*randn(1, N);

figure; histogram(W, 40); title('White Gaussian Noise Histogram');

% Estimate mean and variance
mean_est = mean(W);
var_est = var(W);

% Check stationarity (constant stats over time)
figure; plot(W); title('White Noise Signal'); xlabel('Samples');
%% ---------- Part (d): Y(t) = X(t) + W(t) ----------
clear; clc; close all;

f = 1;                    % freq (Hz)
sigma2 = 0.1;
dt = 0.001; t = 0:dt:2;

X = sin(2*pi*f*t);        % deterministic signal
W = sqrt(sigma2)*randn(size(t));  % white noise
Y = X + W;

figure; 
plot(t,Y); hold on; plot(t,X,'LineWidth',2);
title('Observed Signal Y(t) with Added Noise'); xlabel('Time'); legend('Y(t)', 'X(t)');

% Autocorrelation
[Ryy, lag] = xcorr(Y,'biased');
[Rx, ~] = xcorr(X,'biased');
[Rw, ~] = xcorr(W,'biased');

figure; 
plot(lag*dt,Ryy); hold on; plot(lag*dt,Rx,'LineWidth',1.5);
plot(lag*dt,Rw,'k--'); 
title('Autocorrelation Functions');
legend('Ryy','Rxx','Rww');
xlabel('\tau');
