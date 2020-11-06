%{
% Measure multiple images using the thresholds & conditions defined in measure.m
% Configurations:
%   * prefix, dir, N (line #13-16)
% Output: histogram of ls and props
%}

% Clear history
clc;
clear all;
close all;

% Configurations
prefix = '';
dir = 'images/homography/';
N = 4;

[~, names] = filenames(dir, prefix, N);
all_ls = [];
all_props = [];
for i = 1 : N
    [ls, props] = measure_homography(names(i));
    all_ls = [all_ls ls'];
    all_props = [all_props props'];
end

l1 = all_ls(1, :);
p2 = all_props(2, :);
p3 = all_props(3, :);
p4 = all_props(4, :);
p5 = all_props(5, :);

figure
hist_analysis(l1, "Reference Rectangle Heights");

figure
subplot(2, 2, 1);
hist_analysis(p2, "L2/L1");
subplot(2, 2, 2);
hist_analysis(p3, "C/L1");
subplot(2, 2, 3);
hist_analysis(p4, "L3/L1");
subplot(2, 2, 4);
hist_analysis(p5, "T/L1");