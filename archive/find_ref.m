%{
Localization of the reference rectangle
Input: img - subject image
Procedure:
    1. Construct a value-based thresholding mask (active region) 
    2. Locate the beginning & end of the active per column (a & b)
    3. Compute the median of the beginning & end positions (a_med & b_med)
    4. Compute the height of the active region (b_med - a_med)
Output:
    * ref_end - estimated end position of the reference rectangle (b_med)
    * ref_height - estimated length (b_med - a_med)
%}
function [ref_end, ref_height] = find_ref(img)
    th = 0.2578;
    img = histeq(img);
    hsv = rgb2hsv(img);
    [m, n, ~] = size(img);

    % 1. Mask construction
    mask = zeros(m, n);
    for i = 1 : m
        for j = 1 : n
            v = hsv(i, j, 3);
            if v < th
                mask(i, j) = 1;
            end
        end
    end
%     figure
%     subplot(1, 2, 1);
%     imshow(img);
%     title("Image");
%     subplot(1, 2, 2);
%     imshow(mask);
%     title("Mask");

    % 2. Localization of the active region per column
    as = zeros(1, n);
    bs = zeros(1, n);
    for j = 1 : n
        for i = 1 : m
            if as(j) == 0 && mask(i, j)
                as(j) = i;
            elseif as(j) > 0 && mask(i, j) == 0
                bs(j) = i - 1;
                break
            end
        end
    end
    
    ref_start = median(as);
    ref_end = median(bs);
    ref_height = ref_end - ref_start;
    if ref_height < 0.05 * n
        disp("find_ref failed!!");
    end
end

