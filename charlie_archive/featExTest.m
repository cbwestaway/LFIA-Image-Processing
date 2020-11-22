% clear all;
close all;
% full = imread('0x.jpg');
full = imread('1x.jpg');
% full = imread('10x.jpg');
cropped = imcrop(full);
cropped = im2double(cropped);

% Show the cropped image
figure;
imshow(cropped);
title('Cropped Image');
len = length(cropped);
wid = width(cropped);

figure;
ind = 1;
for threshold = [0.8:0.025:1]
    mask = zeros(len, wid);
    masked = zeros(len, wid);
    % Create a mask based on the threshold
    for i=1:len
     for j=1:wid
        cR = cropped(i, j, 1);
        cG = cropped(i, j, 2);
        if double(cR) / double(cG) > threshold
            mask(i, j) = 1;
        end
     end
    end
    % Seperate the color channels and multiply by the mask
    r = cropped(:,:,1);
    g = cropped(:,:,2);
    b = cropped(:,:,3);
    r = r .* mask;
    g = g .* mask;
    b = b .* mask;
    masked(:,:,1) = r;
    masked(:,:,2) = g;
    masked(:,:,3) = b;
    % Show the mask and masked image in subplot
    subplot(2, 5, ind);
    imshowpair(mask, masked, 'montage');
    title(['Masked w/ Threshold = ', num2str(threshold)]);
    ind = ind + 1;
end
sgtitle('Masking');


% Test Edge Detection Algorithms
% Convert to grayscale
grayed = rgb2gray(cropped);

% Canny
edge_1 = edge(grayed, 'Canny', 'horizontal');
figure;
subplot(1, 4, 1);
imshowpair(grayed, edge_1, 'montage');
title('Canny Edge Detector');

% Sobel
edge_2 = edge(grayed, 'Sobel', 'horizontal');
subplot(1, 4, 2);
imshowpair(grayed, edge_2, 'montage');
title('Sobel Edge Detector');

% Prewitt
edge_3 = edge(grayed, 'Prewitt', 'horizontal');
subplot(1, 4, 3);
imshowpair(grayed, edge_3, 'montage');
title('Prewitt Edge Detector');

% Laplacian of Gaussian
edge_4 = edge(grayed, 'log', 'horizontal');
subplot(1, 4, 4);
imshowpair(grayed, edge_4, 'montage');
title('Laplacian of Gaussian Edge Detector');

sgtitle('Edge Detection Algorithms');
