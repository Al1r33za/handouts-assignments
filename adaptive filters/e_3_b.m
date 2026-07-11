
L6_50 = zeros(numel(X)/25/6,1);

for k=1:3:numel(X)/25/6
    x =mean(X(k:k+5, :));
    L6_50(k) =x * Lw * x';
end
X6_50 =x;figure
plot(L6_50);title('smoothness over time window of 30min 50%');xlim([0,numel(L6_50)]);

L12_25 = zeros(numel(X)/50/3,1);

for k=1:3:numel(X)/50/3
    x =mean(X(k:k+11, :));
    L12_25(k) =x * Lw * x';
end
X12_25 =x;figure
plot(L12_25);title('smoothness over time window of 60min 25%');xlim([0,numel(L12_25)]);

L12_50 = zeros(numel(X)/50/6,1);

for k=1:6:numel(X)/50/6
    x =mean(X(k:k+5, :));
    L12_50(k) =x * Lw * x';
end
X12_50 =x;figure
plot(L12_50);title('smoothness over time window of 60min 50%');xlim([0,numel(L12_50)]);
