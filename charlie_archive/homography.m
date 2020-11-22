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
controlLineHeights = zeros(1, numFiles);
testLineHeights = zeros(1, numFiles);
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
    mCDist = cStart - mEnd;
    fprintf('Marker Control H=%i \n', mCDist);
    % Control Height
    cHeight = cEnd - cStart;
    fprintf('Control Line H =%i \n', cHeight);
    % Store the height proportional to the marker
    controlLineHeights(p) = cHeight / mHeight;
    % Control Test Dist
    cTDist = tStart - cEnd;
    fprintf('Control Test H=%i \n', cTDist);
    % Test Line Height
    tHeight = tEnd - tStart;
    fprintf('Test Line H =%i \n', tHeight);
    % Store the height proportional to the marker
    testLineHeights(p) = tHeight / mHeight;
end

figure;
histogram('Categories', imPaths , 'BinCounts', markerHeights);
% Get mean and std for hist
mu =  num2str(round(mean(markerHeights), 2));
sig = num2str(round(std(markerHeights), 2));
title(['Marker Heights (mu =', mu, ' sigma = ', sig, ')']);
% Probability Distribution
pdMarker = fitdist(markerHeights', 'Normal');
ci = paramci(pdMarker);
disp(ci);

figure;
histogram('Categories', imPaths , 'BinCounts', controlLineHeights);
% Get mean and std for hist
mu =  num2str(round(mean(controlLineHeights), 2));
sig = num2str(round(std(controlLineHeights), 2));
title(['Control Line Heights wrt Marker (mu =', mu, ' sigma = ', sig, ')']);
% Probability Distribution
pdControl = fitdist(controlLineHeights', 'Normal');
ci = paramci(pdControl);
disp(ci);

figure;
histogram('Categories', imPaths , 'BinCounts', testLineHeights);
% Get mean and std for hist
mu =  num2str(round(mean(testLineHeights), 2));
sig = num2str(round(std(testLineHeights), 2));
title(['Test Line Heights wrt Marker (mu =', mu, ' sigma = ', sig, ')']);
% Probability Distribution
pdTest = fitdist(testLineHeights', 'Normal');
ci = paramci(pdTest);
disp(ci);
