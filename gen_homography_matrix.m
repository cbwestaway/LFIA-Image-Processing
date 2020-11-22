%{
% Generate the homography matrices for get_homography_matrix.m
%}

% Clear history
clc;
clear all;
close all;

% Configurations
prefix = '';
dir = 'images/homography/round2.5_zoomed/pixel/one_dl/';
N = 2;

[~, names] = filenames(dir, prefix, 1, N);
matrix = zeros(N, 4);
for i = 1 : N
    [~, ~, c_start, c_end, t_start, t_end] = measure_homography(names(i));
    matrix(i, :) = [c_start, c_end, t_start, t_end];
end
matrix