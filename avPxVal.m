function av = avPxVal(I, startRow, endRow)
    hsvI = rgb2hsv(I);
    px = hsvI(startRow:endRow, :, 3);
    av = mean(px);
end
