%{
% Expriment with N threshold values between a and b
% Configurations:
%   * filename, a, b, N (line #14-18)
%   * thresholding criteria (line#46)
% Output: one mask per experimental threshold
%}

% Clear history
clc;
clear all;
close all;

% Configurations
filename = 'images/round2.5/negative/all_iphone_zoomed/1.jpg';
% negative, all_iphone_zoomed - 0.25
% negative, all_iphone_unzoomed - 0.5
% one_dl, all_iphone_zoomed - 0.375
% one_dl, all_iphone_unzoomed - 0.375
% half_dl, zoomed, hist-eq'ed - 0.2578
% half_dl, unzoomed, hist-eq'ed - 0.125
% one_dl, zoomed, hist-eq'ed - 0.2578
% negative, zoomed, hist-eq'ed - 0.2578
a = 0.25;
b = 0.28125;
N = 9;

% Original image & its dimension
img = imread(filename);
img = histeq(img);
hsv = rgb2hsv(img);
img = im2double(img);
[m, n, ~] = size(img);
figure
imshow(img)

% Create a mask per threshold value
thresholds = linspace(a, b, N);
N = length(thresholds);
figure
for t = 1 : N
    mask = zeros(m, n);
    th = thresholds(t);
    for i = 1 : m
        for j = 1 : n
            r = img(i, j, 1);
            g = img(i, j, 2);
            b = img(i, j, 3);
            h = hsv(i, j, 1);
            s = hsv(i, j, 2);
            v = hsv(i, j, 3);
            if v < th
                mask(i, j) = 1;
            end
        end
    end
    subplot(1, N, t);
    imshow(mask, []);
    title(th);
end