function [Windows,Fs]=framing(filename)
    %class(filename)
    [data,Fs] = audioread(filename);
    %data = abs(hilbert(data1));
    samplesPerWin = floor(Fs*25*(10^-3));
    %samplesPerWin
    %Fs
    overlap =floor(Fs*(10^-2)); 

    numOfFrames = ceil((length(data)-samplesPerWin)/overlap);
    Frames = zeros(numOfFrames+1,samplesPerWin);
    for i = 0:numOfFrames-1
        Frames(i+1,1:samplesPerWin) = data(i*overlap+1:i*overlap+samplesPerWin);
    end

    temp = zeros(1,samplesPerWin); 
    lastLength = length(data)- numOfFrames*overlap;
    temp(1:lastLength) = data(numOfFrames*overlap+1:(numOfFrames*overlap +1 + lastLength-1));  
    Frames(numOfFrames+1, 1:samplesPerWin) = temp;

    frameSize = size(Frames); 
    numOfFrames = frameSize(1); 
    numOfSamplesPerFrame = frameSize(2); 
  
    w = hamming(numOfSamplesPerFrame); 
    Windows = zeros(numOfFrames,numOfSamplesPerFrame);
    for i = 1:numOfFrames
        Windows(i, 1:numOfSamplesPerFrame) = w'.*Frames(i,1:numOfSamplesPerFrame); 
    end 
end