function masked = maskRgbIm(I, mask)
    masked = zeros(length(I), width(I));
    % Seperate the color channels
    r = I(:,:,1);
    g = I(:,:,2);
    b = I(:,:,3);
    % Multiply each channel by the BW mask
    r = r .* mask;
    g = g .* mask;
    b = b .* mask;
    % Combine channels to create the masked image
    masked(:,:,1) = r;
    masked(:,:,2) = g;
    masked(:,:,3) = b;
end
