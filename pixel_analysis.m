%{
    Interpret sets of images using set-specific homography
%}

% Clear history
clc;
clear all;
close all;

% Configurations
PREFIX = "iphone/iphone_zoomed/";
N = 5;
SETS = num2cell([
   3 5;
   2 3;
   1 2;
]);
DIR_NAMES = ["negative" "half_dl" "one_dl"];
HIST_TITLES = ["Negative" "1/2 x Detection Limit" "1 x Detection Limit"];

for i = 1 : 3
    dir_prefix = strcat("images/round2.5/", DIR_NAMES(i), "/n");
    [SET_FROM, SET_TO] = SETS{i, :};
    hist_title = HIST_TITLES(i);
    homography_matrix = get_homography_matrix(i);
    analyze(dir_prefix, PREFIX, SET_FROM, SET_TO, N, homography_matrix, @avRedPx, "Negative");
end

function [] = analyze(DIR_PREFIX, PREFIX, SET_FROM, SET_TO, N, HOMOGRAPHY_MATRIX, interp_func, hist_title)
    N_SET = SET_TO - SET_FROM + 1;
    set_indices = string(linspace(SET_FROM, SET_TO, N_SET)');
    figure
    for set = 1 : N_SET
        dir = strcat(DIR_PREFIX, set_indices(set), '/');
        [~, names] = filenames(dir, PREFIX, 1, N);
        [c_start, c_end, t_start, t_end] = HOMOGRAPHY_MATRIX{set, :};
        results = zeros(1, N);
        for i = 1 : N
            img = imread(names(i));
            img = im2double(img);
            [~, masked] = construct_mask(img, [c_start, c_end; t_start, t_end]);
            stitched = [img masked];
            subplot(N_SET, N, (set-1) * N + i);
            imshow(stitched);
            c_metric = interp_func(img, c_start, c_end);
            t_metric = interp_func(img, t_start, t_end);
            results((set-1) * N + i) = t_metric / c_metric;
        end
    end
    TITLE_PREFIX = "";
    title_text = strcat(TITLE_PREFIX, hist_title);
    sgtitle(title_text, 'FontSize', 15);
    figure
    hist_analysis(results, title_text);
end