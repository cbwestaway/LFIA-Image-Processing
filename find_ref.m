%{
Localization of the reference rectangle
Input: img - subject image
Procedure:
    1. Construct a value-based thresholding mask (active region) 
    2. Locate the beginning & end of the active per row (a & b)
    3. Compute the median of the beginning & end positions (a_med & b_med)
    4. Compute the height of the active region (b_med - a_med)
Output:
    * a - estimated a (a_med)
    * b - estimated b (b_med)
    * l - estimated length (b_med - a_med)
%}
function [a, b, l] = find_ref(img)
    th = 0.5;
    hsv = rgb2hsv(img);
    img = im2double(img);
    [m, n, ~] = size(img);

    % 1. Mask construction
    mask = zeros(m, n);
    for i = 1 : m
        for j = 1 : n
            r = img(i, j, 1);
            g = img(i, j, 2);
            b = img(i, j, 3);
            h = hsv(i, j, 1);
            s = hsv(i, j, 2);
            v = hsv(i, j, 3);
            if v < th
                mask(i, j) = 1;
            end
        end
    end
    figure
    subplot(1, 2, 1);
    imshow(img);
    title("Image");
    subplot(1, 2, 2);
    imshow(mask, []);
    title("Mask");

    % 2. Localization of the active region per row
    as = zeros(1, m);
    bs = zeros(1, m);
    for j = 1 : n
        for i = 1 : m
            if as(i) == 0 && mask(i, j)
                as(i) = i;
            elseif as(i) > 0 && mask(i, j) == 0
                bs(i) = i - 1;
                break
            end
        end
    end
    
    a = median(as);
    b = median(bs);
    l = b - a;
end

