%{
Interpret a list of images
Procedure:
    1. 
Output:
    * 
%}

% Clear history
clc;
clear all;
close all;

% Configurations
prefix = '';
dir = 'images/round2.5/negative/all_iphone_unzoomed/';
N = 15;

[~, names] = filenames(dir, prefix, 1, N);
res = zeros(1, N);
for i = 1 : N
    img = imread(names(i));
    res(i) = interp(img, @getMarker, @applyHomography, @temp)
end

hist_analysis(res, "Result");

function [out] = temp(img, var1, var2)
    imshow(img);
    var1, var2
    out = 1;
end