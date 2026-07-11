% plot for p =7 p=15 p=20

[F, ~] =latticechain(s2, s2, ks2);

figure();
plot(F(7, 1:100));hold on;
plot(F(15,1:100));
plot(F(20,1:100));hold off;title 'fp for s2';
legend p=7 p=15 p=20;

[F, ~] =latticechain(f0, b0, ks3);

figure();
plot(F(7, 1:100));hold on;
plot(F(15,1:100));
plot(F(20,1:100));hold off;title 'fp for s3';
legend p=7 p=15 p=20;