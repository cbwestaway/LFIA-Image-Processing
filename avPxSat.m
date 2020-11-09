function av = avPxSat(I, startRow, endRow)
    wid = width(I);
    startCol = 25;
    endCol = wid - 25;
    % Equilizing the histogram should sharpen the test line
    I = histeq(I);
    hsvI = rgb2hsv(I);
    px = hsvI(startRow:endRow, startCol:endCol, 2);
    av = mean(px ./ ((endRow - startRow) * wid));
end
