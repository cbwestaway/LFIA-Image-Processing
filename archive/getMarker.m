function [mEnd, mHeight] = getMarker(I)
    % Marker height
    mStart = 0;
    mEnd = 0;
    mHeight = 0;
    wid = width(I);
    for i=1:length(I)
        % Identify starting and ending rows of the marker
        if mStart == 0 && isMarker(i, I, wid)
            mStart = i;
        elseif mStart > 0 && mEnd == 0 && isMarker(i, I, wid) == false
            mEnd = i;
            mHeight = i - mStart;
            break;
        end
    end
end


%{
    Detects the black marker above the strip.
    Works well for now but will likely need to make
    a more sophisticated detector.
%}
function isMarker = isMarker(i, I, wid)
    bThresh = 0.25; 
    passThresh = 0.9;
    passes = 0;
    for j=1:wid
        r = I(i, j, 1);
        g = I(i, j, 2);
        b = I(i, j, 3);
        if r < bThresh && g < bThresh && b < bThresh
            passes = passes + 1;
        end
    end
    if passes / wid > passThresh
        isMarker = true;
    else
        isMarker = false;
    end
end