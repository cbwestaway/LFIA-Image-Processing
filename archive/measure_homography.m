%{
% Measurement based on set thresholds & conditions
% Configurations:
%   * th1, th2 (line #14-15)
%   * thresholding conditions
%       for the reference rectangle based on th1 (line#36)
%       for the control & test lines based on th2 (line#40)
% Output:
%   * ls - lengths of the regions (l1, l2, l3, l4, l5)
%   * props - (l1, l2/l1, l3/l1, l4/l1, l5/l1)
%}
function [ls, props] = measure_homography(filename)
    % Original image & its dimension
    img = imread(filename);
    hsv = rgb2hsv(img);
    img = im2double(img);
    [m, n, ~] = size(img);
%     figure
%     imshow(img)

    % Mask creations
    mask = zeros(m, n);
    for i = 1 : m
        for j = 1 : n
            r = img(i, j, 1);
            g = img(i, j, 2);
            b = img(i, j, 3);
            h = hsv(i, j, 1);
            s = hsv(i, j, 2);
            v = hsv(i, j, 3);
            if v < 0.5
                mask(i, j) = 1;
            end
        end
    end
%     figure
%     subplot(1, 2, 1);
%     imshow(img);
%     title("Image");
%     subplot(1, 2, 2);
%     imshow(mask, []);
%     title("Mask");

    % Locate the beginnings & ends of the active regions per column
    % a-b reference rectangle
    % c-d control line
    % e-f test line
    res = zeros(6, n);
    for j = 1 : n
        a = 0;
        b = 0;
        c = 0;
        d = 0;
        e = 0;
        f = 0;
        for i = 1 : m
            if a == 0 && mask(i, j)
                a = i;
            elseif a > 0 && b == 0 && mask(i, j) == 0
                b = i - 1;
            elseif b > 0 && c == 0 && mask(i, j)
                c = i;
            elseif c > 0 && d == 0 && mask(i,j) == 0
                d = i - 1;
            elseif d > 0 && e == 0 && mask(i, j)
                e = i;
            elseif e > 0 && f == 0 && mask(i,j) == 0
                f = i - 1;
                break
            end
        end
        res(1, j) = a;
        res(2, j) = b;
        res(3, j) = c;
        res(4, j) = d;
        res(5, j) = e;
        res(6, j) = f;
    end

    % Trim the incomplete columns
    filtered_res = [];
    next = 1;
    for i = 1 : n
        if min(res(:, i)) > 0
            filtered_res = [filtered_res res(:, i)];
            next = next + 1;
        end
    end

    medians = zeros(1, 6);
    for i = 1 : 6
        medians(i) = median(filtered_res(i, :));
    end

    median_cells = num2cell(medians);
    [a b c d e f] = median_cells{:};

    l1 = b - a;
    l2 = c - b;
    l3 = d - c;
    l4 = e - d;
    l5 = f - e;
    ls = [l1 l2 l3 l4 l5];
    props = [l1 l2/l1 l3/l1 l4/l1 l5/l1];
end

