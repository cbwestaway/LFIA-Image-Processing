% Clear history
clc;
clear all;
close all;

% channel = 1;

% 1 sample per concentration
% plot_single("images/round2.5/negative/all_iphone_zoomed/1.jpg", "Negative");
% plot_single("images/round2.5/one_dl/all_iphone_zoomed/1.jpg", "1 x Detection Limit");
% plot_single("images/round2.5/half_dl/all_iphone_zoomed/7.jpg", "1/2 x Detection Limit");
% get_peak_ratio("images/round2.5/negative/all_iphone_zoomed/1.jpg", channel, 3, 4)
% get_peak_ratio("images/round2.5/one_dl/all_iphone_zoomed/1.jpg", channel, 3, 4)
% get_peak_ratio("images/round2.5/half_dl/all_iphone_zoomed/1.jpg", channel, 4, 5)

% N samples per concentration
% plot_multi("images/round2.5/negative/all_iphone_zoomed/", 15, "Negative");
% plot_multi("images/round2.5/one_dl/all_iphone_zoomed/", 10, "1 x Detection Limit");
% plot_multi("images/round2.5/half_dl/all_iphone_zoomed/", 10, "1/2 x Detection Limit");

peaks1 = get_peaks_multi("images/round2.5/negative/all_iphone_zoomed/", 15);
peaks2 = get_peaks_multi("images/round2.5/half_dl/all_iphone_zoomed/", 10);
peaks3 = get_peaks_multi("images/round2.5/one_dl/all_iphone_zoomed/", 10);
ratios1 = get_ratios(peaks1);
ratios2 = get_ratios(peaks2);
ratios3 = get_ratios(peaks3);

for r = 1 : 4
    d1 = squeeze(ratios1(:, r));
    d2 = squeeze(ratios2(:, r));
    d3 = squeeze(ratios3(:, r));
    group = [repmat({'Negative'}, length(d1), 1); repmat({'1/2 x Detection Limit'}, length(d2), 1); repmat({'1 x Detection Limit'}, length(d3), 1)];
    figure
    boxplot([d1;d2;d3], group);
    xlabel('Concentration');
    ylabel('T/C Ratio');
    switch r
        case 1
            title_text = "R";
        case 2
            title_text = "G";
        case 3
            title_text = "B";
        case 4
            title_text = "R/G";
    end
    title(title_text);
end

function [ratios] = get_ratios(peaks)
    % ratios = N * 4 = N * [r g b r/g]
    [N, ~, ~] = size(peaks);
    ratios = zeros(N, 4);
    for n = 1 : N
        c_rgb = num2cell(squeeze(peaks(n, 1, :))');
        t_rgb = num2cell(squeeze(peaks(n, 2, :))');
        [cr, cg, cb] = c_rgb{:};
        [tr, tg, tb] = t_rgb{:};
        ratios(n, :) = [tr/cr tg/cg tb/cb (tr/tg)/(cr/cg)];
    end
end

function [mean_rgbs, mean_hsvs] = get_mean_intensities(filename)
    img = imread(filename);
    img = im2double(img);
    img = imgaussfilt(img, 15);
    hsv = rgb2hsv(img);
%     img = color_balance(img);
    [M, ~, ~] = size(img);
    mean_rgbs = zeros(3, M);
    mean_hsvs = zeros(3, M);
    for m = 1 : M
        for i = 1 : 3
            mean_rgbs(i, m) = mean(img(m, :, i));
            mean_hsvs(i, m) = mean(hsv(m, :, i));
        end
    end
end

function [ratio] = plot_single(filename, title_text)
    [rgbs, hsvs] = get_mean_intensities(filename);
    plot_base(rgbs, strcat(title_text, " - RGB"));
    plot_base(hsvs, strcat(title_text, " - HSV"));
end

function [] = plot_base(data, title_text)
    figure
    hold on;
    [M, N] = size(data);
    for i = 1 : M
        if M > 1
            switch i
                case 1
                    color = "r";
                case 2
                    color = "g";
                case 3
                    color = "b";
            end
        else
            color = "None";
        end
        x = 1 : N;
        plot(x, -data(i, :), "color", color)
%         findpeaks(-data(i, :), x, "MinPeakDistance", 700, 'MinPeakProminence', 0.002, 'MinPeakWidth', 75, 'Annotate', 'extents');
        findpeaks(-data(i, :), x, "MinPeakDistance", 700, 'MinPeakProminence', 0.002, 'MinPeakWidth', 75);
    end
    title(title_text, 'FontSize', 15);
    hold off;
end

function [min_num_rows] = get_min_num_rows(names)
    [~, N] = size(names);
    num_rows = zeros(1, N);
    for n = 1 : N
        img = imread(names(n));
        [num_rows(n), ~, ~] = size(img);
    end
    min_num_rows = min(num_rows);
end

function [] = plot_multi(dir, N, title_text)
    [~, names] = filenames(dir, "", 1, N);
    img = imread(names(1));
    num_rows = zeros(1, N);
    M = get_min_num_rows(names);
    all_rgbs = zeros(N, 3, M);
    all_hsvs = zeros(N, 3, M);
    for n = 1 : N
        [rgbs, hsvs] = get_mean_intensities(names(n));
        for i = 1 : 3
            all_rgbs(n, i, :) = rgbs(i, 1:M);
            all_hsvs(n, i, :) = hsvs(i, 1:M);
        end
    end

    figure
    hold on;
    for n = 1 : N
        mean_intensities = squeeze(all_rgbs(n, :, :));
        for i = 1 : 3
            switch i
                case 1
                    color = "r";
                case 2
                    color = "g";
                case 3
                    color = "b";
            end
            plot(mean_intensities(i, :), "color", color)
        end
    end
    title(title_text, 'FontSize', 15);
end

function [peaks] = get_peaks(filename)
    % 2 * 3
    % (C/T, R/G/B)
    peaks = zeros(2, 3);
    [rgbs, hsvs] = get_mean_intensities(filename);
    [~, M] = size(rgbs);
    x = 1 : M;
    for i = 1 : 3
        [pks, ~, ~, ~] = findpeaks(-rgbs(i, :), x, "MinPeakDistance", 700, 'MinPeakProminence', 0.002, 'MinPeakWidth', 75, 'Annotate', 'extents');
        [~, s] = size(pks);
        t = pks(s);
        c = pks(s-1);
        peaks(:, i) = [c t];
    end
end

function [peaks] = get_peaks_multi(dir, N)
    % N * [C, T] * [R, G, B]
    % N * 2 * 3
    peaks = zeros(N, 2, 3);
    [~, names] = filenames(dir, "", 1, N);
    for n = 1 : N
        peaks(n, :, :) = get_peaks(names(n));
    end
end