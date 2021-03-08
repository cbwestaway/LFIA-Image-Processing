% Clear history
clc;
clear all;
close all;

load v_ratios;
y = zeros(1, 21);
x = zeros(1, 21);
concentrations = 0:6;
i = 1;
for m = 1 : 7
    for n = 1 : 3
        y(i) = v_ratios(m,n);
        x(i) = concentrations(m) / 6;
        i = i + 1;
    end
end

temp = x;
x = y;
y = temp;

p = polyfit(x, y, 1);
yfit = polyval(p,x);

scatter(x,y)
hold on
plot(x, yfit)
grid on
title("Linear Regression Relation between Signal & Concentration");
xlabel("Ceoncentration (DL)");
ylabel("T/C Ratio of V-Channel Intensity");

yresid = y - yfit;
SSresid = sum(yresid.^2);
SStotal = (length(y)-1) * var(y);
rsq = 1 - SSresid/SStotal;