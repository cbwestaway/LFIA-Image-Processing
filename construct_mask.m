function [mask, masked] = construct_mask(img, rects)
    [M, N, ~] = size(img);
    mask = zeros(M, N);
    [num_rects, ~] = size(rects);
    for m = 1 : M
        for nr = 1 : num_rects
            if m >= rects(nr, 1) && m <= rects(nr, 2)
                mask(m, :) = 1;
                break
            end
        end
    end
    masked = maskRgbIm(img, mask);
end