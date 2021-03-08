% Clear history
clc;
clear all;
close all;

dir = 'images/round4/1DL_B/';
prefix = 'IMG_';
output_dir = dir;
output_prefix = '';
ia = 2957;
N = 30;
oa = 1;

ib = ia + N;
ob = oa + N;
[~, names, ~] = filenames(dir, prefix, ia, N);
[~, output_names] = filenames(output_dir, output_prefix, oa, N);
img = imread(names(1));
[~,rect] = imcrop(img);

figure
for i = 1 : N
    name = names(i);
    img = imread(name);
    cropped = imcrop(img, rect);
    cropped = imrotate(cropped, 270);
    subplot(1, N, i);
    imshow(cropped);
    imwrite(cropped, output_names(i));
end