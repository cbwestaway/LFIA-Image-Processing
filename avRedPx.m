function av = avRedPx(I, startRow, endRow)
    wid = width(I);
    sum = 0;
    for i=startRow:endRow
        % Temp: ignore edges due to bad cropping
        for j=50:(wid-50)
            r = I(i, j, 1);
            sum = sum + r;
        end
    end
    av = sum / ((endRow - startRow) * wid);
end
