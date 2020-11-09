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
%     ref_end = ref_end + 16;
%     ref_height = ref_height + 8;
    [c_start, c_end, t_start, t_end] = apply_homography_func(ref_end, ref_height);
    og = img;
    masked = visualize(img, ref_end - ref_height, ref_end, c_start, c_end, t_start, t_end, 0);
%     a = round(c_start * 0.95);
    a = round((ref_end - ref_height) * 0.75);
    b = round(t_end * 1.05);
    stitched = [og masked];
    stitched = stitched(a:b, :, :);
%     figure
    imshow(stitched, []);
    c_metric = interp_func(img, c_start, c_end);
    t_metric = interp_func(img, t_start, t_end);
    res = t_metric / c_metric;
end

function [res] = visualize(img, r_start, r_end, c_start, c_end, t_start, t_end, delta)
    [m, n, ~] = size(img);
    mask = zeros(m, n);
    c_start = c_start * (1-delta);
    c_end = c_end * (1+delta);
    t_start = t_start * (1-delta);
    t_end = t_end * (1+delta);
    for i = 1 : m
        if (i > r_start && i < r_end) || (i > c_start && i < c_end) || (i > t_start && i < t_end)
            mask(i, :) = 1;
        end
    end
    res = maskRgbIm(img, mask);
end