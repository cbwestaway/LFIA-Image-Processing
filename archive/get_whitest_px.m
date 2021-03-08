function [r, g, b] = get_whitest_px(img)
    % Smooth out high frequency noise
    img = imgaussfilt(img, 1);
    % Find the brightest pixel in the image
    S = sum(img, 3);
    [~,idx] = max(S(:));
    [i, j] = ind2sub(size(S),idx);
    % Return the rgb values of the brightest pixel
    r = img(i, j, 1);
    g = img(i, j, 2);
    b = img(i, j, 3);
end

