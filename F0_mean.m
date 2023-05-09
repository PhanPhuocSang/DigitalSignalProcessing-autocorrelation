% ham tinh gia tri trung binh
function [mean] = F0_mean(F0)
    count = 0;
    sum = 0;
    for i=1:length(F0)
        if(F0(i)>0)
            count = count + 1;
            sum = sum + F0(i);
        end
    end
    mean = sum/count;
end
