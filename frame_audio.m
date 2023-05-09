function [frames] = frame_audio(x, n_frames, frame_size)
% n : tín hiệu đầu vào
% n_frames: số lượng khung
% frame_size: số mẫu trong 1 khung tín hiệu 

    frames = zeros(n_frames, frame_size);
    t = 0;
    for i = 1 : n_frames
        frames(i,:) = x(t+1 : t+frame_size);
        t = t + frame_size;
    end
end