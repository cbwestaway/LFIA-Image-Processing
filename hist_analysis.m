%{
% Histogram analysis of y with mean & standard deviation calculation
% Enable line #10 for outlier elimination
% By default > 3 MAD values are removed
% Output: histogram plot + mu & std as legend
%}

function [] = hist_analysis(y, title_text)
% (Histogram/Distribution) Analysis
% y = rmoutliers(y);
[n, x] = hist(y);
histogram(y, 'FaceAlpha', 0.1, 'FaceColor','#77AC30', 'EdgeAlpha', 0.5)
mu = mean(y);
sigma = std(y);
n = length(y);
sem = sigma / sqrt(n);
% labels = num2str(n');
% text(x, n, labels, 'horizontalalignment', 'center', 'verticalalignment', 'bottom', 'FontSize', 15);
legend({sprintf('mean = %3.4f, std = %3.4f, sem=%3.4f', mu, sigma, sem)}, 'location', 'best', 'FontSize', 15);
pd = fitdist(y', 'Normal');
ci = paramci(pd);
mu_ci_lower = ci(1, 1);
mu_ci_upper = ci(2, 1);
legend({sprintf('CI of mean = (%3.4f, %3.4f)', mu_ci_lower, mu_ci_upper)}, 'location', 'best', 'FontSize', 15);
title(title_text, 'FontSize', 15);