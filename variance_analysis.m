% Clear history
clc;
clear all;
close all;

load positives;
% A = negative_1';
% B = negative_2';
% C = negative_3';
A = positive_A';
B = positive_B';
% C = positive_3';

% Normal probability plot
% Test for normality using a Lilliefors test
normplot([A B])
% legend({'Negative I','Negative II', 'Negative III'})
legend({'Positive A','Positive B'})

lillietest_results = [lillietest(A) lillietest(B)];

mean_A = mean(A);
mean_B = mean(B);
% mean_C = mean(C);

[h_AB ,sig_AB, ci_AB] = ttest2(A, B);
% [h_AC ,sig_AC, ci_AC] = ttest2(A, C);
% [h_BC ,sig_BC, ci_BC] = ttest2(B, C);