function av = avRedPx(I, startRow, endRow)
    px = I(startRow:endRow, :, 1);
    av = mean(px, 'all');
end
