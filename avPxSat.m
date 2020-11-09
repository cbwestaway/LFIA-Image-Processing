function av = avPxSat(I, startRow, endRow)
    global wid;
    hsvI = rgb2hsv(I);
    sum = 0;
    for i=startRow:endRow
        % Temp: ignore edges due to bad cropping
        for j=50:(wid-50)
            s = hsvI(i, j, 2);
            sum = sum + s;
        end
    end
    av = sum / ((endRow - startRow) * wid);
end
