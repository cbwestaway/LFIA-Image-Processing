%{
    This template was taken from the pixel analysis file.
    Iterating over the images and color balancing.
%}

% Clear history
clc;
clear all;
close all;

% Configurations
N = 5;
PREFIX = "iphone/iphone_zoomed/";
SETS = num2cell([
   3 5;
   2 3;
   1 2;
]);
DIR_NAMES = ["negative" "half_dl" "one_dl"];
HIST_TITLES = ["Negative" "1/2 x Detection Limit" "1 x Detection Limit"];
FIG_TITLES = ["Negative" "Half Detection Limit" "One Detection Limit"];

for i = 1 : 3
    dir_prefix = strcat("images/round2.5/", DIR_NAMES(i), "/n");
    [SET_FROM, SET_TO] = SETS{i, :};
    hist_title = HIST_TITLES(i);
    figure;
    color_balance_test(dir_prefix, PREFIX, SET_FROM, SET_TO, N);
    sgtitle(FIG_TITLES(i));
end

function [results] = color_balance_test(DIR_PREFIX, PREFIX, SET_FROM, SET_TO, N)
    N_SET = SET_TO - SET_FROM + 1;
    set_indices = string(linspace(SET_FROM, SET_TO, N_SET)');
    results = zeros(1, N * N_SET);
    for set = 1 : N_SET
        dir = strcat(DIR_PREFIX, set_indices(set), '/');
        [~, names] = filenames(dir, PREFIX, 1, N);
        for i = 1 : N
            img = imread(names(i));
            img = im2double(img);
            balanced = color_balance(img);
            stitched = [img balanced];
            subplot(N_SET, N, (set-1) * N + i);
            imshow(stitched);
        end
    end
end
