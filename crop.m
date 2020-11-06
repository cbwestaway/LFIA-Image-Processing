% Clear history
clc;
clear all;
close all;

dir = 'images/n2/';
prefix = 'Pixel';
output_dir = 'images/n2/pixel_cropped/';
output_prefix = '';
N = 10;
[~, names, ~] = filenames(dir, prefix, N);
[~, output_names] = filenames(output_dir, output_prefix, N);
img = imread(names(1));
[~,rect] = imcrop(img);

figure
for i = 1 : N
    name = names(i);
    img = imread(name);
    cropped = imcrop(img, rect);
    subplot(1, N, i);
    imshow(cropped);
    imwrite(cropped, output_names(i));
end