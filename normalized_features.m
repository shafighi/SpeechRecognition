function [normalized_features_output]= normalized_features(filename,mel_coef_count)
    [Win,Fs]=framing(filename);
    mfcc_features =[];
    %size(Win)
    
    for j=1:size(Win,1)
        x = Win(j,:);
        if x~=0           
            mfcc_features(j,:) = my_mfcc(x',Fs,mel_coef_count);
            energy(j,1) = sum(x.^2);
        end
    end
    normalized_features_output = [mfcc_features/norm(mfcc_features),energy/norm(energy)];
    normalized_features_output = (normalized_features_output*16+16);
end