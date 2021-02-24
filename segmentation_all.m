% Clear history
clc;
clear all;
close all;


concentrations = {'0', '1-6', '1-3', '1-2', '2-3', '5-6', '1'};
assays = {'s1', 's2', 's3'};

M = 4 : 6;
v_ratios = zeros(7, 9);
rg_ratios = zeros(7, 9);
for c=1:length(concentrations)
    conc = concentrations(c);
    ind = 1;
    for s = assays
        DIR = "images/round3/named_3/";
        DIR = strcat(DIR, string(conc), '/', string(s));
        for m = 1 : length(M)
            filename = strcat(DIR, "_", string(M(m)), ".jpg");
            [rgbs, hsvs] = get_mean_intensities(filename);
            % The three data sets we care about
            v_data = squeeze(hsvs(3, :));
            r_data = squeeze(rgbs(1, :));
            g_data = squeeze(rgbs(2, :));
            x = 1:length(v_data);
            [vpks, ~] = findpeaks(-v_data, x, "MinPeakDistance", 325, 'NPeaks', 2);
            [rpks, ~] = findpeaks(-r_data, x, "MinPeakDistance", 325, 'NPeaks', 2);
            [gpks, ~] = findpeaks(-g_data, x, "MinPeakDistance", 325, 'NPeaks', 2);
            v_ratio = (1 + vpks(2)) / (1 + vpks(1));
            rg_ratio = ((rpks(2)/gpks(2)))/((rpks(1)/gpks(1)));
            v_ratios(c, ind) = v_ratio;
            rg_ratios(c, ind) = rg_ratio;
            ind = ind + 1;
        end
    end
end

figure;
boxplot(v_ratios', 'labels', concentrations);
title('Pixel Value');
ylabel('T/C Ratio');
xlabel('Concentration');

figure;
boxplot(rg_ratios', 'labels', concentrations);
title('R/G Ratio');
ylabel('T/C Ratio');
xlabel('Concentration');

function [mean_rgbs, mean_hsvs] = get_mean_intensities(filename)
    img = imread(filename);
    img = im2double(img);
    img = imgaussfilt(img, 5);
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
