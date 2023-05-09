% ham tinh do lech chuan
function [F0std] = F0_std(F0)
    mean = F0_mean(F0);
    sum = 0;
    count = 0;
    for i = 1: length(F0)
        if F0(i) > 0
            sum = sum + (F0(i) - mean)^2;
            count = count + 1;
        end
    end
    variance = sum/(count-1);
    F0std = sqrt(variance);
end