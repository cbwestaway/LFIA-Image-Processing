function [clStart, clEnd, tlStart, tlEnd] = applyHomography(mEnd, mHeight)    
    % Below are mean proportions derived from homography_analysis.m
    % Distance from the marker to the test line w.r.t. to the marker
    mcDist = 0.79;
    % Height of the test line w.r.t. to the marker
    clHeight = 0.06;
    % Distance from the control line to the test line w.r.t. to the marker
    ctDist = 0.63;
    % Height of the test line w.r.t. to the marker
    tlHeight = 0.06;
    % Control line calculations
    mcDist = round(mcDist * mHeight);
    clStart = mEnd + mcDist;
    clHeight = round(clHeight * mHeight);
    clEnd = clStart + clHeight;
    % Test line calulations
    ctDist = round(ctDist * mHeight);
    tlStart = clEnd + ctDist;
    tlHeight = round(tlHeight * mHeight);
    tlEnd = tlStart + tlHeight;
end
