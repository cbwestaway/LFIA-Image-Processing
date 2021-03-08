function [clStart, clEnd, tlStart, tlEnd] = applyHomography(mEnd, mHeight)    
    % Below are mean proportions derived from homography_analysis.m
    % Distance from the marker to the control line w.r.t. to the marker
    mcDist = 0.7871;
    % Height of the control line w.r.t. to the marker
    clHeight = 0.0825;
    % Distance from the control line to the test line w.r.t. to the marker
    ctDist = 0.6405;
    % Height of the test line w.r.t. to the marker
    tlHeight = 0.0716;
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
