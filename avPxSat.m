function av = avPxSat(I, startRow, endRow)
    wid = width(I);
    hsvI = rgb2hsv(I);
    px = hsvI(startRow:endRow, :, 2);
    av = mean(px ./ ((endRow - startRow) * wid));
end
