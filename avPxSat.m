function av = avPxSat(I, startRow, endRow)
    hsvI = rgb2hsv(I);
    px = hsvI(startRow:endRow, :, 2);
    av = mean(px);
end
