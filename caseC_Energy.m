function [] = caseC_Energy()

    % nested function to reduce duplicated code
    function enOrigRegAB_ph = avg_en(segOrig_ph)
    % for each occurrence of phoneme in 's' or 'aa' array    
    for i = 1:size(segOrig_ph,1) 
        X = abs(fft(segOrig_ph(i,:)));                                  % |X(k)|
        indA = round(length(segOrig_ph)*[400 1600]/8000);               % index of freq 400 and 1600
        indB = round(length(segOrig_ph)*[2400 4000]/8000);              % index of freq 2400 and 4000
        X_A = X(indA(1):indA(2));                                       % X(k) array within zoneA
        X_B = X(indB(1):indB(2));                                       % X(k) array within zoneB
        aveEng_A = 10*log10((1/(indA(2)-indA(1)+1))*sum(X_A.^2));       % Ave_En of zoneA
        aveEng_B = 10*log10((1/(indB(2)-indB(1)+1))*sum(X_B.^2));       % Ave_En of zoneB
        enOrigRegAB_ph(i,:) = [aveEng_A, aveEng_B];                     % store in array
    end
    end
    
segAllData = load("segAllData.mat");
MDPK0_SA1_ph = load("MDPK0_SA1_ph.mat");
enOrigRegAB_phAA = avg_en(segAllData.segOrig_phAA);
enOrigRegAB_phS = avg_en(segAllData.segOrig_phS);
enMDPK0_SA1_ph = avg_en(MDPK0_SA1_ph.MDPK0_SA1_ph);


save('enAllData.mat', "enOrigRegAB_phS","enOrigRegAB_phAA")

tiledlayout(1,2);
nexttile;
histogram(enOrigRegAB_phAA(:,1),"BinWidth",1)
title('Energy of "aa" in Zones A and B');
xlabel('Energy/dB');
ylabel('Occurences of "aa"');
hold on;
histogram(enOrigRegAB_phAA(:,2),"BinWidth",1)
xlabel('Energy/dB');
ylabel('Occurences of "aa"');
legend('ZoneA: 0.4kHz-1.6kHz','ZoneB: 2.4kHz-4kHz')
nexttile;
histogram(enOrigRegAB_phS(:,1),"BinWidth",1)
title('Energy of "s" in Zones A and B');
xlabel('Energy/dB');
ylabel('Occurences of "s"');
hold on;
histogram(enOrigRegAB_phS(:,2),"BinWidth",1)
xlabel('Energy/dB');
ylabel('Occurences of "s"');
legend('ZoneA: 0.4kHz-1.6kHz','ZoneB: 2.4kHz-4kHz')

end

