%{
Interpret a list of images
%}

% Clear history
clc;
clear all;
close all;

% Configurations
prefix = '';
dir = 'images/round2.5/half_dl/all_iphone_zoomed/';
N = 10;
% N = 15 for negative results

figure
[~, names] = filenames(dir, prefix, 1, N);
res = zeros(1, N);
for i = 1 : N
    img = imread(names(i));
    img = im2double(img);
    subplot(N/5, 5, i);
    res(i) = interp(img, @find_ref, @applyHomography, @avRedPx);
end

figure
hist_analysis(res, "Results");
