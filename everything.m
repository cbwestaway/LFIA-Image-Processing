% Clear history
clc;
clear all;
close all;

% get_ratio("images/round3.5/negative_Flash/26.jpg");

DIR = "images/round3.5/negative_living_room/";
N = 30;
ratios = zeros(1, N);
for n = 1 : N
    filename = strcat(DIR, string(n), ".jpg");
    ratio = get_ratio(filename);
    ratios(n) = ratio;
end

% result statistics
mean = mean(ratios);
sd = std(ratios);
cv = sd / mean

figure;
boxplot(ratios);

function [ratio] = get_ratio(filename)
    [rgbs, hsvs] = get_mean_intensities(filename);
    v_data = squeeze(hsvs(3, :));
    x = 1:length(v_data);
    
    [vpks, ~, w] = findpeaks(-v_data, x, "MinPeakDistance", 450, 'NPeaks', 2);
    figure
    findpeaks(-v_data, x, "MinPeakDistance", 450, 'NPeaks', 2);
    title(filename);
    ratio = (1+vpks(2)) / (1+vpks(1));
end

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
