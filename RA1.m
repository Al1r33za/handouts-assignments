clc; clear; close all;

Nsim = 50000;

n_max = 100;
n_values = 1:n_max;

gif_name = 'CLT_animation.gif';

for n = n_values

    X = rand(Nsim, n);

    S = sum(X, 2);

    mu = n * 0.5;
    sigma = sqrt(n * 1/12);

    histogram(S, 'Normalization', 'pdf', 'BinWidth', 0.1); hold on;

    x = linspace(min(S), max(S), 300);
    y = 1/(sigma*sqrt(2*pi)) * exp(-(x-mu).^2/(2*sigma^2));
    plot(x, y, 'r', 'LineWidth', 2);

    title(['Central Limit Theorem  |  n = ' num2str(n)]);
    xlabel('S_n');
    ylabel('Density');
    xlim([mu - 5*sigma, mu + 5*sigma]);
    grid on;

    drawnow;

    frame = getframe(gcf);
    im = frame2im(frame);
    [A, map] = rgb2ind(im, 256);

    if n == 1
        imwrite(A, map, gif_name, 'gif', 'LoopCount', Inf, 'DelayTime', 0.1);
    else
        imwrite(A, map, gif_name, 'gif', 'WriteMode', 'append', 'DelayTime', 0.1);
    end

    hold off;
end
