function [] = caseC_Energy()

    % nested function to reduce duplicated code
    function enOrigRegAB_ph = avg_en(segOrig_ph)
    % for each occurrence of phoneme in 's' or 'aa' array    
    for i = 1:size(segOrig_ph,1) 
        X = abs(fft(segOrig_ph(i,:)));           % |X(k)|
        indA = round(200*[400 1600]/8000);       % index of freq 400 and 1600
        indB = round(200*[2401 4000]/8000);      % index of freq 2400 and 4000
        X_A = X(indA(1):indA(2));                % X(k) array within zoneA
        X_B = X(indB(1):indB(2));                % X(k) array within zoneB
        aveEng_A = 10*log10((1/(indA(2)-indA(1)+1))*sum(X_A.^2));
        aveEng_B = 10*log10((1/(indB(2)-indB(1)+1))*sum(X_B.^2));
        enOrigRegAB_ph(i,:) = [aveEng_A, aveEng_B];
    end
    end
    
segAllData = load("segAllData.mat");
enOrigRegAB_phAA = avg_en(segAllData.segOrig_phAA);
enOrigRegAB_phS = avg_en(segAllData.segOrig_phS);

save('enAllData.mat', "enOrigRegAB_phS","enOrigRegAB_phAA")

tiledlayout(1,2);
nexttile;
histogram(enOrigRegAB_phAA(:,1),"NumBins",20)
title('Energy of "aa" between 0.4kHz - 1.6kHz ');
xlabel('Energy/dB');
ylabel('Occurences of "aa"');
hold on;
histogram(enOrigRegAB_phAA(:,2),"NumBins",20)
title('Energy of "aa" between 2.4kHz - 4kHz ');
xlabel('Energy/dB');
ylabel('Occurences of "aa"');
nexttile;
histogram(enOrigRegAB_phS(:,1),"NumBins",20)
title('Energy of "s" between 0.4kHz - 1.6kHz ');
xlabel('Energy/dB');
ylabel('Occurences of "s"');
hold on;
histogram(enOrigRegAB_phS(:,2),"NumBins",20)
title('Energy of "s" between 2.4kHz - 4kHz ');
xlabel('Energy/dB');
ylabel('Occurences of "s"');

end

