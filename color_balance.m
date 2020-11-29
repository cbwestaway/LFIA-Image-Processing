function balanced = color_balance(img)
    [r, g, b] = get_mean_strip_color(img);
    base_white = 1;
    % define scaling so that the strip appears to be white
    r_s = base_white / r;
    g_s = base_white / g;
    b_s = base_white / b;
    % multiply the image by the scaling to color balance
    balanced = img;
    balanced(:, :, 1) = balanced(:, :, 1) .* r_s;
    balanced(:, :, 2) = balanced(:, :, 2) .* g_s;
    balanced(:, :, 3) = balanced(:, :, 3) .* b_s;
end

