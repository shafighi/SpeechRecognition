function [result]= my_mfcc(x,Fs,mfcc_count)

    samples = floor(size(x,1)/mfcc_count);
    samplesPerWin = floor(1125 * log(1 + samples / 700));
    tri = triang(samplesPerWin);
    win = zeros(size(x,1),ceil(size(x,1)/samplesPerWin));
    
    

    win(:,1) = [tri ; zeros(size(x,1)-samplesPerWin,1)];
    win(:,ceil(size(x,1)/samplesPerWin)) = [zeros(size(x,1)-samplesPerWin,1);tri];
    for i=1:ceil(size(x,1)/samplesPerWin)-2
       win(:,i+1) = [zeros((i-1)*samplesPerWin+ceil(samplesPerWin*(3/4)),1) ; tri ; zeros(size(x,1)-i*samplesPerWin-ceil(samplesPerWin*(3/4)),1)];
    end

    f = (1:size(x,1));
    size(x,1);
    %mel = 2595 * log(1 + f / 700);%1125
    %plot(x);

    w = hamming(floor(0.7*size(x,1)));
    w = [w ; zeros(size(x,1)-floor(0.7*size(x,1)),1)];
    x_ham = x.* w;
    x_fft = fft(x_ham);
    size(x_ham);
    size(x_fft);
    mel_inv = 700*(exp(f/1125)-1);
%    max(mel)
 %   min(mel)

    %temp = 700*(exp(size(x_fft,1)/1125)-1);
    
    %mel = mel(1:temp);
  %  mel
   % mel_inv;
    mel_fft = abs(x_fft(floor(mel_inv(f))+1));
    mel_fft = mel_fft./ max(mel_fft);
    %plot(mel_fft)
    each = zeros(size(x,1),ceil(size(x,1)/samplesPerWin));
    
    for i=1:ceil(size(x,1)/samplesPerWin)
     %  size(mel_fft)
     %  size(win(:,i))
       each(:,i) = mel_fft.*win(:,i); 
    end
    %plot(each(:,10))
    energy = zeros(ceil(size(x,1)/samplesPerWin),1);
    for i=1:ceil(size(x,1)/samplesPerWin)
       energy(i) = sum(each(:,i).^ 2);
    end

    energy_log = log(energy);
    dct_of_log = dct(energy_log);

    save dct_of_log
    result = dct_of_log;

end