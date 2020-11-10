function av = avRedPx(I, startRow, endRow)
    wid = width(I);
    px = I(startRow:endRow, :, 1);
    av = mean(px ./ ((endRow - startRow) * wid));
end
