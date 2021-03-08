function av = avGreyVal(I, startRow, endRow)
    grayI = rgb2gray(I);
    av = mean(grayI(startRow:endRow), 'all');
end
