% Clear history
clc;
clear all;
close all;

concentrations = {'0', '1/6', '1/3', '1/2', '2/3', '5/6', '1'};
DIR = "images/round3/selected/";
M = 1 : 6;
v_ratios = zeros(7, 6);
rg_ratios = zeros(7, 6);
for n = 0:6
    for m = 1 : length(M)
        filename = strcat(DIR, string(n), "_", string(M(m)), ".jpg");
        
        [rgbs, hsvs] = get_mean_intensities(filename);
        v_data = squeeze(hsvs(3, :));
        x = 1:length(v_data);
        
        [vpks, ~, w] = findpeaks(-v_data, x, "MinPeakDistance", 325, 'NPeaks', 2);
        v_ratio = (1+vpks(2)) / (1+vpks(1));
        v_ratios(n+1, m) = v_ratio; 
        
        %{
        Pixel Analysis Techniques from Previous Experiments 
            % rg ratio
              r_data = squeeze(rgbs(1, :));
              g_data = squeeze(rgbs(2, :));
              [rpks, ~] = findpeaks(-r_data, x, "MinPeakDistance", 325, 'NPeaks', 2);
              [gpks, ~] = findpeaks(-g_data, x, "MinPeakDistance", 325, 'NPeaks', 2);
              rg_ratio = ((rpks(2)/gpks(2)))/((rpks(1)/gpks(1)));
              rg_ratios(n+1, m) = rg_ratio;
            % peaks
              v_ratio = vpks(2) / vpks(1);
            % peaks x width
              v_ratio = (vpks(2) * w(2)) / (vpks(1) * w(1));

            % shifted peaks
            v_ratio = (1+vpks(2)) / (1+vpks(1));
            % shifted peaks x width
              v_ratio = ((1+vpks(2)) * w(2)) / ((1+vpks(1)) * w(1));

            % prominance
              v_ratio = p(2) / p(1);
            % prominance * width
              v_ratio = (p(2) * w(2)) / (p(1) * w(1));
        %}     
    end
end

% result statistics
means = mean(v_ratios, 2);
sds = std(v_ratios, 0, 2);
[r, LB, UB, F, df1, df2, p] = ICC(v_ratios, '1-1');

figure;
boxplot(v_ratios', 'labels', concentrations);
title('Mixed Lighting Conditions');
ylabel('T/C Ratio');
xlabel('Concentration');

% figure;
% boxplot(rg_ratios', 'labels', concentrations);
% title('R/G Ratio');
% ylabel('T/C Ratio');
% xlabel('Concentration');

function [mean_rgbs, mean_hsvs] = get_mean_intensities(filename)
    img = imread(filename);
    img = im2double(img);
    img = imgaussfilt(img, 10);
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
