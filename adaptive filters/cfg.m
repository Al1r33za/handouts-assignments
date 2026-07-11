clearvars -except SpeedMat WeightMat clflag


if ~exist('SpeedMat', 'var')
    SpeedMat = readmatrix('.\PeMSD7_V_228.csv');end

if ~exist('WeightMat', 'var')
    WeightMat = readmatrix('.\PeMSD7_W_228.csv');end

if (clflag == 1)
    pmax =20;
    % choosing 3 different sensors:
    s1 = SpeedMat(:, 53);
    s2 = SpeedMat(:, 130);
    s3 = SpeedMat(:, 199);

    [r1, n] = xcorr(s1, 'biased');r1 =r1(n>-1);
    [r2, n] = xcorr(s2, 'biased');r2 =r2(n>-1);
    [r3, n] = xcorr(s3, 'biased');r3 =r3(n>-1);

    R1 =toeplitz(r1(1:pmax));
    R2 =toeplitz(r2(1:pmax));
    R3 =toeplitz(r3(1:pmax));
end

if (clflag == 2)
    rng(13);

    nodes =50;
    sens =randi([1,228], nodes, 1);

    X =SpeedMat(:, sens);
    distance =WeightMat(sens, sens);
end