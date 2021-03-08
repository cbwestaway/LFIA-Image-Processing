% Normally shouldn't be needed
% clear all;
close all;
% Load images for comparison
prefix = '';
dir = 'images/homography/';
N = 4;
[~, imPaths] = filenames(dir, prefix, N);
numFiles = length(imPaths);
% define arrays for storing height data
markerHeights = zeros(1, numFiles);
mcDists = zeros(1, numFiles);
clHeights = zeros(1, numFiles);
ctDists = zeros(1, numFiles);
tlHeights = zeros(1, numFiles);
for p=1:numFiles
    I = imread(imPaths{p});
    % Height and distance counts
    mStart = 0;
    mEnd = 0;
    cStart = 0;
    cEnd = 0;
    tStart = 0;
    tEnd = 0;
    % Count rows of pixels
    i = 1;
    while i < len
       % Get the color of the middle pixel
       r = I(i, round(wid/2), 1);
       % Set the color threshhold for the black marker
       if r == 0
            if mStart == 0
                mStart = i;
            elseif mEnd > 0 && cStart == 0
                cStart = i;
            elseif cEnd > 0 && tStart == 0
                tStart = i;
            end 
       elseif r == 255
            if mStart > 0 && mEnd == 0
               mEnd = i - 1;
            elseif cStart > 0 && cEnd == 0
                cEnd = i - 1;
            elseif tStart > 0 && tEnd == 0
                tEnd = i - 1;
            end
       end
       if tEnd > 0
           break;
       end
       i = i + 1;
    end
    disp('==========================================');
    fprintf('Data below for %s \n', imPaths{p});
    disp('==========================================');
    % Marker Height
    mHeight = mEnd - mStart;
    fprintf('Marker H=%.1f \n', mHeight);
    markerHeights(p) = mHeight;
    % Marker to Control Dist
    mcDist = (cStart - mEnd) / mHeight;
    mcDists(p) = mcDist;
    fprintf('Marker Control H=%i \n', mCDist);
    % Control Height
    cHeight = (cEnd - cStart) / mHeight;
    fprintf('Control Line H =%i \n', cHeight);
    % Store the height proportional to the marker
    clHeights(p) = cHeight;
    % Control Test Dist
    ctDist = (tStart - cEnd) / mHeight;
    ctDists(p) = ctDist;
    fprintf('Control Test H=%i \n', cTDist);
    % Test Line Height
    tHeight = (tEnd - tStart) / mHeight;
    fprintf('Test Line H =%i \n', tHeight);
    % Store the height proportional to the marker
    tlHeights(p) = tHeight;
end
figure;
histogram('Categories', imPaths , 'BinCounts', markerHeights);
% Get mean and std for hist
mu =  num2str(round(mean(markerHeights), 2));
sig = num2str(round(std(markerHeights), 2));
title(['Marker Heights (mu =', mu, ', sigma = ', sig, ')']);

figure;
histogram('Categories', imPaths , 'BinCounts', mcDists);
% Get mean and std for hist
mu =  num2str(round(mean(mcDists), 2));
sig = num2str(round(std(mcDists), 2));
title(['Marker Control Distances wrt Marker (mu =', mu, ', sigma = ', sig, ')']);

figure;
histogram('Categories', imPaths , 'BinCounts', clHeights);
% Get mean and std for hist
mu =  num2str(round(mean(clHeights), 2));
sig = num2str(round(std(clHeights), 2));
title(['Control Line Heights wrt Marker (mu =', mu, ', sigma = ', sig, ')']);

figure;
histogram('Categories', imPaths , 'BinCounts', ctDists);
% Get mean and std for hist
mu =  num2str(round(mean(ctDists), 2));
sig = num2str(round(std(ctDists), 2));
title(['Control Test Distances wrt Marker (mu =', mu, ', sigma = ', sig, ')']);

figure;
histogram('Categories', imPaths , 'BinCounts', tlHeights);
% Get mean and std for hist
mu =  num2str(round(mean(tlHeights), 2));
sig = num2str(round(std(tlHeights), 2));
title(['Test Line Heights wrt Marker (mu =', mu, ', sigma = ', sig, ')']);

