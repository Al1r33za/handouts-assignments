%--------------------------
p =15;                                  % Order (taps and weights)
train_data =s2(1:11000);                % training data
tests_data = ...
    [zeros(11000,1);s2(11001:end)];     % test data
w = zeros(p,1);                         % w initial
mu =.02e-4;                               % learning rate
%--------------------------
LearnCurve =zeros(numel(s2), 1);
PredictSig =zeros(numel(s2), 1);
TestingErr =zeros(numel(s2), 1);

% LMS method ...
for n =1:numel(s2)-p
    test_cond =n <=numel(train_data)-p;

    % Training-------------------
    if (test_cond)
        x =flip(train_data(n:n+p-1));
        d =x(1);

        y =w' * x;
        e =d - y;

        w = w + mu * e * x;

        LearnCurve(n+p) =e.^2;
        PredictSig(n+p) =y;
    % Testing---------------------
    else
        x =flip(tests_data(n:n+p-1));

        y =w' * x;
        e =d - y;

        TestingErr(n+p) =e;
        PredictSig(n+p) =y;
    end
end
w2 =w;
% Plotting-----------------------------------------------------------------
figure();
plot(LearnCurve)
title('fig(c.1) Learning Curve s2');xlim([1,n]);
figure();
plot(1:n, s2(1:n), 1:n, PredictSig(1:n))
title('fig(c.2) Predicted and true signal s2');
xlim([10000,12000]);legend('original', 'trained');
figure();
plot(TestingErr(10985:end));xlim([1, 1682]);title('fig(c.3) Test error s2')


%--------------------------
p =15;                                  % Order (taps and weights)
train_data =s3(1:11000);                % training data
tests_data = ...
    [zeros(11000,1);s3(11001:end)];     % test data
w = zeros(p,1);                         % w initial
mu =.02e-4;                               % learning rate
%--------------------------
LearnCurve =zeros(numel(s3), 1);
PredictSig =zeros(numel(s3), 1);
TestingErr =zeros(numel(s3), 1);

% LMS method ...
for n =1:numel(s3)-p
    test_cond =n <=numel(train_data)-p;

    % Training-------------------
    if (test_cond)
        x =flip(train_data(n:n+p-1));
        d =x(1);

        y =w' * x;
        e =d - y;

        w = w + mu * e * x;

        LearnCurve(n+p) =e.^2;
        PredictSig(n+p) =y;
    % Testing---------------------
    else
        x =flip(tests_data(n:n+p-1));

        y =w' * x;
        e =d - y;

        TestingErr(n+p) =e;
        PredictSig(n+p) =y;
    end
end
w3 =w;
% Plotting-----------------------------------------------------------------
plot(LearnCurve)
title('fig(c.1) Learning Curve s3');xlim([1,n]);
figure();
plot(1:n, s3(1:n), 1:n, PredictSig(1:n))
title('fig(c.2) Predicted and true signal s3');
xlim([10000,12000]);legend('original', 'trained');
figure();
plot(TestingErr(10985:end));xlim([1, 1682]);title('fig(c.3) Test error s3');