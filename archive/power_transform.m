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
filename = 'images/round2.5/one_dl/n2/pixel/Zoomed/1.jpg';
a = 3.25;
b = 6.625;
N = 9;

% Original image & its dimension
img = imread(filename);
img = imrotate(img, 90);
hsv = rgb2hsv(img);
img = im2double(img);
[m, n, ~] = size(img);
% figure
% imshow(img)

% Create a mask per threshold value
powers = linspace(a, b, N);
N = length(powers);
figure
for t = 1 : N
    p = powers(t);
    subplot(1, N, t);
    res = pt(img, p);
    imshow(res, []);
    title(p);
end

function [res] = pt(img, power)
    res = cat(3, img(:, :, 1).^power, img(:, :, 2).^power, img(:, :, 3).^power);
end