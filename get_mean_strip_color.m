function [r, g, b] = get_mean_strip_color(img)
    len = length(img);
    wid = width(img);
    img = histeq(img);
    % get the last bit of the image
    strip_end = img(len-50:len, :);
    r = mean(strip_end(1), 'all');
    disp(r);
    g = mean(strip_end(2), 'all');
    disp(g);
    b = mean(strip_end(3), 'all');
    disp(b);
end

