function av = avRedPx(I, startRow, endRow)
    wid = width(I);
    startCol = 25;
    endCol = wid - 25;
    % Equilizing the histogram should sharpen the test line
    I = histeq(I);
    px = I(startRow:endRow, startCol:endCol, 1);
    av = mean(px ./ ((endRow - startRow) * wid));
end
