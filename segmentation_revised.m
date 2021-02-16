% Clear history
clc;
clear all;
close all;

DIR = "images/round3/selected/";
M = 4 : 6;
v_ratios = zeros(3, 7);
rg_ratios = zeros(3, 7);
for n = 0:6
    for m = 1 : length(M)
        filename = strcat(DIR, string(n), "_", string(M(m)), ".jpg");
        [rgbs, hsvs] = get_mean_intensities(filename);
        % The three data sets we care about
        v_data = squeeze(hsvs(3, :));
        r_data = squeeze(rgbs(1, :));
        g_data = squeeze(rgbs(2, :));
        x = 1:length(v_data);
        [vpks, ~] = findpeaks(-v_data, x, "MinPeakDistance", 325, 'NPeaks', 2);
        [rpks, ~] = findpeaks(-r_data, x, "MinPeakDistance", 325, 'NPeaks', 2);
        [gpks, ~] = findpeaks(-g_data, x, "MinPeakDistance", 325, 'NPeaks', 2);
        v_ratio = (1+vpks(2)) / (1+vpks(1));
        rg_ratio = ((rpks(2)/gpks(2)))/((rpks(1)/gpks(1)));
        v_ratios(m, n+1) = v_ratio;
        rg_ratios(m, n+1) = rg_ratio;
    end
end

figure;
boxplot(v_ratios);

figure;
boxplot(rg_ratios);

function [mean_rgbs, mean_hsvs] = get_mean_intensities(filename)
    img = imread(filename);
    img = im2double(img);
    hsv = rgb2hsv(img);
    [rows, ~, ~] = size(img);
    mean_rgbs = zeros(3, rows);
    mean_hsvs = zeros(3, rows);
    for m = 1 : rows
        for i = 1 : 3
            mean_rgbs(i, m) = mean(img(m, :, i));
            mean_hsvs(i, m) = mean(hsv(m, :, i));
        end
    end
end
