function process_data(fileName)
    [y, Fs] = audioread(fileName);
    frame_size = round(0.03*Fs); %so mau trong 1 khung tin hieu 30ms
    n_frames = floor(length(y)/frame_size); %so luong khung
    t = length(y)/Fs; % do dai tgian tin hieu
    [frames] = frame_audio(y, n_frames, frame_size);
    RSN = remove_silent_noise(frames, n_frames, frame_size); % ma tran khu nhieu cua frames
    F0= zeros(1, n_frames);  % vecto chua cac gia tri F0 cua tin hieu, nhieu thi F0 = 0, -> dung de hien thi duong F0
    R = [];     % ma tran tu tuong quan -> dung de hien thi ACF

    for i = 1: n_frames
        r = ACF(frames(i,:));
        if(max(RSN(i,:)) > 0) 
            [maxpeak, pos] = max_peak_in_frame(r);
            if maxpeak > 0.35 % nguong = 0.35
                F0_frame = Fs/pos;
                if F0_frame >=70 && F0_frame <=400
                     F0(i) = F0_frame;
                end
            end
        end
        R = [R; r]; % add vecto r vao ma tran R
    end
    
    F0mean = F0_mean(F0);   
    F0std = F0_std(F0);

    voidFrame = 0; 
    unvoidFrame = 0; 
    meanLab = 0;
    stdLab = 0;

    switch fileName
        % lab trong file kiểm thử
        case 'phone_F1.wav'
            voidFrame = 26; %32
            unvoidFrame = 80;% 15
            meanLab = 217;
            stdLab = 23; 
        case 'phone_M1.wav'
            voidFrame = 25;
            unvoidFrame = 49;
            meanLab = 122;
            stdLab = 18;
        case 'studio_F1.wav'
            voidFrame = 35; %31
            unvoidFrame = 78;
            meanLab = 232;
            stdLab = 40;
        case 'studio_M1.wav'
            voidFrame = 42;
            unvoidFrame = 24;
            meanLab = 113;
            stdLab = 26;

        % lab trong file huấn luyện
        case 'phone_F2.wav'
            voidFrame = 51; 
            unvoidFrame = 15;% 26
            meanLab = 145;
            stdLab = 33.7; 
        case 'phone_M2.wav'
            voidFrame = 29;
            unvoidFrame = 78;
            meanLab = 129;
            stdLab = 18.6;
        case 'studio_F2.wav'
            voidFrame = 31; %31
            unvoidFrame = 83;
            meanLab = 200;
            stdLab = 46.1;
        case 'studio_M2.wav'
            voidFrame = 43;
            unvoidFrame = 47;
            meanLab = 155;
            stdLab = 30.8;
    end

    figure('Name',fileName);
    subplot(4,2,1);
    plot(frames(voidFrame,:));
    title("Voiced frame");
    
    subplot(4,2,3);
    plot(R(voidFrame,:));
    title("ACF of Voiced frame");


    subplot(4,2,2);
    plot(frames(unvoidFrame,:));
    title("Unvoiced frame");
    
    subplot(4,2,4);
    plot(R(unvoidFrame,:));
    title("ACF of Unvoiced frame");
    
    subplot(4,2,7:8);
    lin = linspace(0, t, length(y));
    plot(lin,y);
    title("Signal");
    xlabel("time(s)");
    ylabel("bien do");
    xlim([0 t]); 
   
    subplot(4,2,5:6);
    lin2 = linspace(0,t,length(F0));
        for i=1:length(F0) 
            if F0(i) > 0
                plot(lin2(i),F0(i),'b.');
                hold on;
            end
        end
        hold off;
        ylabel('Hz');
        xlim([0 t]);
        ylim([0 450]);
        title(strcat('F0mean=', num2str(F0mean), ', F0std=', num2str(F0std)));
    
    delta_F0mean = abs(F0mean - meanLab); 
    delta_F0std = abs(F0std - stdLab);
    fprintf('Độ lệch các giá trị trong: %s\n', fileName);
    disp(['     delta_mean = ' num2str(delta_F0mean) ', delta_std = ' num2str(delta_F0std)]);

    %save('process_dataWorkspace.mat');    
end