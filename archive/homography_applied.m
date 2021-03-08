% Normally shouldn't be needed
% clear all;
close all;
% Load images for comparison
prefix = '';
dir = 'images/round2/all/';
N = 5;
[~, imPaths] = filenames(dir, prefix, N);
numFiles = length(imPaths);

global wid;
for p=1:numFiles
    I = imread(imPaths{p});
    len = length(I);
    wid = width(I);
    % Below are mean proportions derived from homography_analysis.m
    % Distance from the marker to the test line w.r.t. to the marker
    mcDist = 0.79;
    % Height of the test line w.r.t. to the marker
    clHeight = 0.06;
    % Distance from the control line to the test line w.r.t. to the marker
    ctDist = 0.63;
    % Height of the test line w.r.t. to the marker
    tlHeight = 0.06;
    % Marker height
    mStart = 0;
    mEnd = 0;
    mHeight = 0;
    for i=1:len
        % Identify starting and ending rows of the marker
        if mStart == 0 && isMarker(i, I)
            mStart = i;
        elseif mStart > 0 && mEnd == 0 && isMarker(i, I) == false
            mEnd = i;
            mHeight = i - mStart;
            break;
        end
    end
    % Create a mask based on the marker height
    mask = zeros(len, wid);
    % Show the marker in the mask
    mask(mStart:mEnd, :) = 1;
    % Control line calculations
    mcDist = round(mcDist * mHeight);
    clStart = mEnd + mcDist;
    clHeight = round(clHeight * mHeight);
    clEnd = clStart + clHeight;
    % Show the control line in the mask
    mask(clStart:clEnd, :) = 1;
    % Test line calulations
    ctDist = round(ctDist * mHeight);
    tlStart = clEnd + ctDist;
    tlHeight = round(tlHeight * mHeight);
    tlEnd = tlStart + tlHeight;
    % Show the test line in the mask
    mask(tlStart:tlEnd, :) = 1;
    
    % Plot the original image, mask and masked image
    figure;
    subplot(1, 3, 1);
    imshow(I);
    title('Original');
    subplot(1, 3, 2);
    imshow(mask);
    title('Mask');
    % Convert to double for masking
    dI = im2double(I);
    masked = maskRgbIm(dI, mask);
    subplot(1, 3, 3);
    imshow(masked);
    title('Masked Image');
    sgtitle(imPaths{p});
end

%{
    Detects the black marker above the strip.
    Works well for now but will likely need to make
    a more sophisticated detector.
%}
function isMarker = isMarker(i, I)
    global wid;
    bThresh = 70; 
    passThresh = 0.8;
    passes = 0;
    for j=1:wid
        r = I(i, j, 1);
        g = I(i, j, 2);
        b = I(i, j, 3);
        if r < bThresh && g < bThresh && b < bThresh
            passes = passes + 1;
        end
    end
    if passes / wid > passThresh
        isMarker = true;
    else
        isMarker = false;
    end
end
