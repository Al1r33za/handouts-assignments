
L3 = zeros(numel(X)/50/3, 1);
L6 = zeros(numel(X)/50/6, 1);
L9 = zeros(numel(X)/50/9, 1);
L12 =zeros(numel(X)/15/12, 1);


for k=1:3:numel(X)/50
    x =mean(X(k:k+2, :));
    L3((k+2)/3) =x * Lw * x';
end
X3 = x;
figure
plot(L3);title('smoothness over time window of 15min');

for k=1:6:numel(X)/50
    x =mean(X(k:k+5, :));
    L6((k+5)/6) =x * Lw * x';
end
X6 = x;
figure
plot(L6);title('smoothness over time window of 30min')

for k=1:9:numel(X)/50
    x =mean(X(k:k+8, :));
    L9((k+8)/9) =x * Lw * x';
end
X9 = x;
figure
plot(L9);title('smoothness over time window of 45min')

for k=1:12:numel(X)/50
    x =mean(X(k:k+11, :));
    L12((k+11)/12) =x * Lw * x';
end
X12 = x;
figure
plot(L12);title('smoothness over time window of 60min')