function av = avGreenPx(I, startRow, endRow)
    px = I(startRow:endRow, :, 2);
      av = mean(px, 'all');
end
