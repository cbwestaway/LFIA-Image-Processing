function av = avRGRatio(I, startRow, endRow)
    rVals = I(startRow:endRow, :, 1);
    gVals = I(startRow:endRow, :, 2);
    rg = rVals ./ gVals;
    av = mean(rg);
end
