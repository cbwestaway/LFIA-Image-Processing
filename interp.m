%{
Localization of the test & control lines
Input: filename - filename of the subject image
Procedure:
    1. Call the find_ref_func to locate the reference rectangle
    2. Call the apply_homography_func to locate the test & control lines
    3. Call the interp_func to interpret the test & control lines
Output: res - synthesized metric (e.g. T/C ratio of the R-/S-channel values)
%}

function [res] = interp(img, find_ref_func, apply_homography_func, interp_func)
    [ref_end, ref_height] = find_ref_func(img);
    [c_start, c_end, t_start, t_end] = apply_homography_func(ref_end, ref_height);
    c_metric = interp_func(img, c_start, c_end);
    t_metric = interp_func(img, t_start, t_end);
    res = t_metric / c_metric;
end