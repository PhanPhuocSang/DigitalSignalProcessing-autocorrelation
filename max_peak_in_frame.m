% ham tim dinh cuc bo cao nhat
function [maxpeak, position] = max_peak_in_frame(frame)
    maxpeak = 0; 
    position = 0; 
    for i = 2:length(frame)-1  % bo qua diem cuc dai toan cuc
        if (frame(i) > frame(i-1)) && (frame(i) > frame(i+1))
            if frame(i) > maxpeak
                maxpeak = frame(i);
                position = i;
            end
        end
    end
end