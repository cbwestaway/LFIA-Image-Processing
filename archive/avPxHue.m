function av = avPxHue(I, startRow, endRow)
    hsvI = rgb2hsv(I);
    px = hsvI(startRow:endRow, :, 1);
      av = mean(px, 'all');
end
