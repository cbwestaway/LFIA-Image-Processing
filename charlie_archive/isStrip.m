function isStrip = isStrip(i, I)
    cols = width(I);
    passes = 0;
    for j = 1:cols
        r = I(i, j, 1);
        if r == 0
            passes = passes + 1;
        end
    end
    if  passes / cols > 0.5
        isStrip = true;
    else
        isStrip = false;
    end
end
