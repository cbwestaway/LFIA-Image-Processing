%{
Interpret a list of images
%}

% Clear history
clc;
clear all;
close all;

% Configurations
prefix = '';
dir = 'images/round2.5/negative/all_iphone_zoomed/';
N = 10;
% N = 15 for negative results

figure
[~, names] = filenames(dir, prefix, 1, N);
res = zeros(1, N);
for i = 1 : N
    img = imread(names(i));
    img = im2double(img);
    subplot(N/5, 5, i);
    res(i) = interp(img, @getMarker, @applyHomography, @avRedPx);
end
  sgtitle('Original Images Adjacent to Masked Images');

figure
hist_analysis(res, "T/C Ratio Using Pixel R-Channel Values");
