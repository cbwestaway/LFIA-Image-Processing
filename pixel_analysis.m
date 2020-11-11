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
FIG_TITLES = ["Negative" "Half Detection Limit" "One Detection Limit"];
% CSV_FILENAME_PREFIX = "results_";

% >>>> Edit title suffix (to indicate the pre-processing method), e.g. "HE'ed "
% title_suffix = " HE";

for i = 1 : 3
    dir_prefix = strcat("images/round2.5/", DIR_NAMES(i), "/n");
    [SET_FROM, SET_TO] = SETS{i, :};
    hist_title = HIST_TITLES(i);
    homography_matrix = get_homography_matrix(i);
    fig_title = strcat("figs/", FIG_TITLES(i));
    analyze(dir_prefix, PREFIX, SET_FROM, SET_TO, N, homography_matrix, @avRedPx, strcat(hist_title, " - R-Channel Analysis"), strcat(fig_title, " - R-Channel Analysis", ".jpg"));
    analyze(dir_prefix, PREFIX, SET_FROM, SET_TO, N, homography_matrix, @avBluePx, strcat(hist_title, " - B-Channel Analysis"), strcat(fig_title, " - B-Channel Analysis", ".jpg"));
    analyze(dir_prefix, PREFIX, SET_FROM, SET_TO, N, homography_matrix, @avGreenPx, strcat(hist_title, " - G-Channel Analysis"), strcat(fig_title, " - G-Channel Analysis", ".jpg"));
    analyze(dir_prefix, PREFIX, SET_FROM, SET_TO, N, homography_matrix, @avPxHue, strcat(hist_title, " - Pixel Hue Analysis"), strcat(fig_title, " - Pixel Hue Analysis", ".jpg"));
    analyze(dir_prefix, PREFIX, SET_FROM, SET_TO, N, homography_matrix, @avPxSat, strcat(hist_title, " - Pixel Saturation Analysis"), strcat(fig_title, " - Pixel Saturation Analysis", ".jpg"));
    analyze(dir_prefix, PREFIX, SET_FROM, SET_TO, N, homography_matrix, @avPxVal, strcat(hist_title, " - Pixel Value (Intensity) Analysis"), strcat(fig_title, " - Pixel Value Analysis", ".jpg"));
    analyze(dir_prefix, PREFIX, SET_FROM, SET_TO, N, homography_matrix, @avGreyVal, strcat(hist_title, " - Grey Scale Analysis"), strcat(fig_title, " - Grey Scale Analysis", ".jpg"));
    analyze(dir_prefix, PREFIX, SET_FROM, SET_TO, N, homography_matrix, @avRGRatio, strcat(hist_title, " - R/G Ratio Analysis"), strcat(fig_title, " - R-G Ratio Analysis", ".jpg"));
%     csv_filename = strcat(CSV_FILENAME_PREFIX, DIR_NAMES(i), ".csv");
%     writematrix(results, csv_filename);
end

function [results] = analyze(DIR_PREFIX, PREFIX, SET_FROM, SET_TO, N, HOMOGRAPHY_MATRIX, interp_func, hist_title, fig_filename)
    SHOW_STITCHED = false;
    N_SET = SET_TO - SET_FROM + 1;
    set_indices = string(linspace(SET_FROM, SET_TO, N_SET)');
    if SHOW_STITCHED
        figure
    end
    results = zeros(1, N * N_SET);
    for set = 1 : N_SET
        dir = strcat(DIR_PREFIX, set_indices(set), '/');
        [~, names] = filenames(dir, PREFIX, 1, N);
        [c_start, c_end, t_start, t_end] = HOMOGRAPHY_MATRIX{set, :};
        for i = 1 : N
            img = imread(names(i));
            img = im2double(img);
            if SHOW_STITCHED
                % >>>> Need to edit this section to add processed image
                [~, masked] = construct_mask(img, [c_start, c_end; t_start, t_end]);
                stitched = [img masked];
                subplot(N_SET, N, (set-1) * N + i);
                imshow(stitched);
            end
            img = histeq(img);
            c_metric = interp_func(img, c_start, c_end);
            t_metric = interp_func(img, t_start, t_end);
            results((set-1) * N + i) = t_metric / c_metric;
        end
    end
%     TITLE_PREFIX = "";
%     title_text = strcat(TITLE_PREFIX, hist_title);
    if SHOW_STITCHED
        sgtitle(hist_title, 'FontSize', 15);
    end
    figure
    hist_analysis(results, hist_title);
    saveas(gcf, fig_filename);
end