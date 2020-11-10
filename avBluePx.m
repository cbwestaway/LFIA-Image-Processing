function av = avBluePx(I, startRow, endRow)
    px = I(startRow:endRow, :, 3);
    av = mean(px);
end

