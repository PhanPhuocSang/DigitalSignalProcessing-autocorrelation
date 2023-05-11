% ham xoa nhieu 
function [newSig] = remove_silent_noise(frames, n_frames, frame_size)
   newSig = zeros(n_frames, frame_size); 
   nguong = 0.005;
   for i = 1: n_frames
       maxVal = max(frames(i,:));
       if maxVal > nguong
           newSig(i,:) = frames(i,:);
       end
   end
end