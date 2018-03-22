
mel_coef_count=12;
iteration = 4;
logP =[];
%kmeans_count =30;
% feature(1,:,:)= normalized_features('t11.wav',mel_coef_count);
% feature(2,:,:)= normalized_features('t14.wav',mel_coef_count);
% feature(3,:,:)= normalized_features('t22.wav',mel_coef_count);
% feature(4,:,:)= normalized_features('t25.wav',mel_coef_count);
% feature(5,:,:)= normalized_features('t36.wav',mel_coef_count);
% feature(6,:,:)= normalized_features('t43.wav',mel_coef_count);
% feature(7,:,:)= normalized_features('t47.wav',mel_coef_count);

feature1= normalized_features('t11.wav',mel_coef_count);
feature2= normalized_features('t14.wav',mel_coef_count);
feature3= normalized_features('t22.wav',mel_coef_count);
feature4= normalized_features('t25.wav',mel_coef_count);
feature5= normalized_features('t36.wav',mel_coef_count);
feature6= normalized_features('t43.wav',mel_coef_count);
feature7= normalized_features('t47.wav',mel_coef_count);

% os = [feature(1,:,:),feature(2,:,:),feature(3,:,:),feature(4,:,:),feature(5,:,:),feature(6,:,:),feature(7,:,:)]
% os = squeeze(os)
 os = [feature1;feature2;feature3;feature4;feature5;feature6;feature7];
%[idx,centroids]=kmeans(feature,kmeans_count);
s1 = state; s2 = state; s3 = state; s4 = state; s5 = state; s6 = state; s7 = state;
s8 = state; s9 = state; s10 = state; s11 = state; s12 = state; s13 = state; s14 = state; s15 = state;

mmean = mean(os);
os_mean = os - repmat(mmean,size(os,1),1);
ccov = cov(os_mean); 
% Ps = [
%       0.75 0.25 0 0 0 0 0 0 0 0 0 0 0 0 0;
%         0 0.75 0.25 0 0 0 0 0 0 0 0 0 0 0 0;
%         0 0 0.75 - 0 0 - 0 0 - 0 0 0 0 -;
%         0 0 0 0.75 0.25 0 0 0 0 0 0 0 0 0 0;
%         0 0 0 0 0.75 0.25 0 0 0 0 0 0 0 0 0;
%         - 0 0 - 0 0.75 - 0 0 - 0 0 0 0 -;
%         0 0 0 0 0 0 0.75 0.25 0 0 0 0 0 0 0;
%         0 0 0 0 0 0 0 0.75 0.25 0 0 0 0 0 0;
%         - 0 0 - 0 0 0 0 0.75 - 0 0 0 0 -;
%         0 0 0 0 0 0 0 0 0 0.4 0.3 0.3 0 0 0;
%         0 0 0 0 0 0 0 0 0 0 0.4 0 0.3 0.3 0;
%         0 0 0 0 0 0 0 0 0 0 0 0.75 0 0.25 0;
%         0 0 0 0 0 0 0 0 0 0 0 0.3 0.4 0.4 0;
%         - 0 0 - 0 0 - 0 0 - 0 0 0 0.75 -;
%         ]

s1 = initial(s1,'A0',[1 0.75;2 0.25],mmean,ccov,0,1);
s2 = initial(s2,'A1',[2 0.75;3 0.25],mmean,ccov,0,2);
s3 = initial(s3,'A2',[3 0.75;15 0.25],mmean,ccov,0,3);
s4 = initial(s4,'N0',[4 0.75;5 0.25],mmean,ccov,0,4);
s5 = initial(s5,'N1',[5 0.75;6 0.25],mmean,ccov,0,5);
s6 = initial(s6,'N2',[6 0.75;15 0.25],mmean,ccov,0,6);
s7 = initial(s7,'S0',[7 0.75;8 0.25],mmean,ccov,0,7);
s8 = initial(s8,'S1',[8 0.75;9 0.25],mmean,ccov,0,8);
s9 = initial(s9,'S2',[9 0.75;15 0.25],mmean,ccov,0,9);
s10 = initial(s10,'silence0',[10 0.4;11 0.3;12 0.3],mmean,ccov,1,10);
s11 = initial(s11,'silence1',[11 0.4;13 0.3;14 0.3],mmean,ccov,0,11);
s12 = initial(s12,'silence2',[12 0.75;4 0.25],mmean,ccov,0,12);
s13 = initial(s13,'silence3',[13 0.4;12 0.3;14 0.3],mmean,ccov,0,13);
s14 = initial(s14,'silence4',[14 0.75; 15 0.25],mmean,ccov,0,14);
s15 = initial(s15,'null',[15 1],mmean,ccov,0,15);

hmm1 = hmm; hmm2 = hmm; hmm3 = hmm; hmm4 = hmm; hmm5 = hmm; hmm6 = hmm; hmm7 = hmm;
states_base = [s1,s2,s3,s4,s5,s6,s7,s8,s9,s10,s11,s12,s13,s14,s15];

% initial(hmm1,feature1);
% initial(hmm2,feature2);
% initial(hmm3,feature3);
% initial(hmm4,feature4);
% initial(hmm5,feature5);
% initial(hmm6,feature6);
% initial(hmm7,feature7);
% 
% hmm_state1 = composeSentemceHMM(hmm1,'NAN NA NASA SAN',states_base);
% hmm_state2 = composeSentemceHMM(hmm2,'NASA SANSA NA NAS',states_base);
% hmm_state3 = composeSentemceHMM(hmm3,'NASA NA SANSA NA NAN SA NAS',states_base);
% hmm_state4 = composeSentemceHMM(hmm4,'NAN NA NASA SAN',states_base);
% hmm_state5 = composeSentemceHMM(hmm5,'NASA SANSA NA NAS',states_base);
% hmm_state6 = composeSentemceHMM(hmm6,'SANSA NA NAN SAN',states_base);
% hmm_state7 = composeSentemceHMM(hmm7,'NASA NA SANSA NA NAN SA NAS',states_base);


    osc{1} = feature1;
    osc{2} = feature2;
    osc{3} = feature3;
    osc{4} = feature4;
    osc{5} = feature5;
    osc{6} = feature6;
    osc{7} = feature7;
    
for iter =1:iteration
    hmm1 = path(hmm1,feature1,'NAN NA NASA SAN',states_base);
    hmm2 = path(hmm2,feature2,'NASA SANSA NA NAS',states_base);
    hmm3 = path(hmm3,feature3,'NASA NA SANSA NA NAN SA NAS',states_base);
    hmm4 = path(hmm4,feature4,'NAN NA NASA SAN',states_base);
    hmm5 = path(hmm5,feature5,'NASA SANSA NA NAS',states_base);
    hmm6 = path(hmm6,feature6,'SANSA NA NAN SAN',states_base);
    hmm7 = path(hmm7,feature7,'NASA NA SANSA NA NAN SA NAS',states_base);

    zetas{1} = hmm1.zeta;
    zetas{2} = hmm2.zeta;
    zetas{3} = hmm3.zeta;
    zetas{4} = hmm4.zeta;
    zetas{5} = hmm5.zeta;
    zetas{6} = hmm6.zeta;
    zetas{7} = hmm7.zeta;

    %zetas = cat(1,hmm1.zeta,hmm2.zeta,hmm3.zeta,hmm4.zeta,hmm5.zeta,hmm6.zeta,hmm7.zeta);

    lamdas{1} = hmm1.lamda;
    lamdas{2} = hmm2.lamda;
    lamdas{3} = hmm3.lamda;
    lamdas{4} = hmm4.lamda;
    lamdas{5} = hmm5.lamda;
    lamdas{6} = hmm6.lamda;
    lamdas{7} = hmm7.lamda;


    s1 = update(s1,zetas,lamdas,osc);
    s2 = update(s2,zetas,lamdas,osc);
    s3 = update(s3,zetas,lamdas,osc);
    s4 = update(s4,zetas,lamdas,osc);
    s5 = update(s5,zetas,lamdas,osc);
    s6 = update(s6,zetas,lamdas,osc);
    s7 = update(s7,zetas,lamdas,osc);
    s8 = update(s8,zetas,lamdas,osc);
    s9 = update(s9,zetas,lamdas,osc);
    s10 = update(s10,zetas,lamdas,osc);
    s11 = update(s11,zetas,lamdas,osc);
    s12 = update(s12,zetas,lamdas,osc);
    s13 = update(s13,zetas,lamdas,osc);
    s14 = update(s14,zetas,lamdas,osc);
    s15 = update(s15,zetas,lamdas,osc);

    states_base = [s1,s2,s3,s4,s5,s6,s7,s8,s9,s10,s11,s12,s13,s14,s15];
    temp = 0;
    for t=1:size(hmm1.C)
        temp = temp  - log(hmm1.C(t)); 
    end
    for t=1:size(hmm2.C)
        temp = temp  - log(hmm2.C(t)); 
    end
        for t=1:size(hmm3.C)
        temp = temp  - log(hmm3.C(t)); 
    end
    for t=1:size(hmm4.C)
        temp = temp  - log(hmm4.C(t)); 
    end
    for t=1:size(hmm5.C)
        temp = temp  - log(hmm5.C(t)); 
    end
    for t=1:size(hmm6.C)
        temp = temp  - log(hmm6.C(t)); 
    end
    for t=1:size(hmm7.C)
        temp = temp  - log(hmm7.C(t)); 
    end

    logP = [logP,temp];
 
  
end
