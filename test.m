
clear;
         
            fidList = fopen('dataTIMIT_labAssign2022_usedToStud/dataTIMIT_labAssign2022_usedToStud/listData.txt','rt');
            
            indAARow = 1;
            indSRow = 1;
            indRowMDPK0_SA1 = 1;
            
            while 1
                fileName = fscanf(fidList,'%s',1);
            
                if (strcmp(fileName,'.')==1)
                    break
                end
                
                % read label file
                labelFileDir = append('dataTIMIT_labAssign2022_usedToStud/dataTIMIT_labAssign2022_usedToStud/labels/', fileName, '.lab');
                fidLabel = fopen(labelFileDir,'rt');
                
                % read inpSigWave
                inpWavFileDir = append('dataTIMIT_labAssign2022_usedToStud/dataTIMIT_labAssign2022_usedToStud/wavOrig/', fileName, '.wav');
                [inpSigWave, FsIn] = audioread(inpWavFileDir);
                
                % read outSigWave
                outWavFileDir = append('dataTIMIT_labAssign2022_usedToStud/dataTIMIT_labAssign2022_usedToStud/wavFilt/', fileName, '.wav');
                [outSigWave, FsOut] = audioread(outWavFileDir);
            
                while ~feof(fidLabel)
                    timeStart = fscanf(fidLabel,'%f',1);
                    timeEnd = fscanf(fidLabel,'%f',1);
                    label = fscanf(fidLabel,'%s',1);
            
                    if (strcmp(label,'aa')==1)
                        % define segment time, convert time to mmsec
                        timePhStart = timeStart/(10^4);
                        timePhEnd = timeEnd/(10^4);
            
                        % calculate formula (2)
                        timeSegStart = timePhStart + ((timePhEnd-timePhStart)/2)-12.5;
                        timeSegEnd = timePhStart + ((timePhEnd-timePhStart)/2)+12.5;
                        
                        % calculate start and end number of signal, convert mmsec to
                        % sec, round to nearest decimal or integer
                        numSigStart = round(FsIn*(timeSegStart/(10^3)));
                        numSigEnd = round(FsIn*(timeSegEnd/(10^3)));
                        
                        for indAAColumn = numSigStart:numSigEnd
                            segOrig_phAA(indAARow,indAAColumn-numSigStart+1) = inpSigWave(indAAColumn,1);
                            segFiltphAA(indAARow,indAAColumn-numSigStart+1) = outSigWave(indAAColumn,1);
                        end
            
                        indAARow = indAARow + 1;
            
                    elseif (strcmp(label,'s')==1)
                        timePhStart = timeStart/(10^4);
                        timePhEnd = timeEnd/(10^4);
            
                        % calculate formula (2)
                        timeSegStart = timePhStart + ((timePhEnd-timePhStart)/2)-12.5;
                        timeSegEnd = timePhStart + ((timePhEnd-timePhStart)/2)+12.5;
                        
                        % calculate start and end number of signal, convert mmsec to
                        % sec, round to nearest decimal or integer
                        numSigStart = round(FsIn*(timeSegStart/(10^3)));
                        numSigEnd = round(FsIn*(timeSegEnd/(10^3)));
            
                        for indSColumn = numSigStart:numSigEnd
                            segOrig_phS(indSRow,indSColumn-numSigStart+1) = inpSigWave(indSColumn,1);
                            segFiltphS(indSRow,indSColumn-numSigStart+1) = outSigWave(indSColumn,1);
                        end
                        indSRow = indSRow + 1;
                    end
                end
                if(strcmp(fileName,'MDPK0/SA1')==1)
                    timeLength = (0:25/200:25-25/200);
                    
                    figure('Name','Segment Waveform MDPK0/SA1.wav_AA');
                    plot(timeLength, segOrig_phAA(indRowMDPK0_SA1,1:200),'g',timeLength, segFiltphAA(indRowMDPK0_SA1,1:200),'b');
                    xlabel('Time');
                    ylabel('Magnitude')
                    legend('Original Waveform', 'Filtered Waveform');
                    set(gcf,'position',[0,300,800,300]);
                      
                    figure('Name','Segment Waveform MDPK0/SA1.wav_S');
                    plot(timeLength, segOrig_phS(indRowMDPK0_SA1,1:200),'g',timeLength, segFiltphS(indRowMDPK0_SA1,1:200),'b');
                    xlabel('Time');
                    ylabel('Magnitude')
                    legend('Original Waveform', 'Filtered Waveform');
                    set(gcf,'position',[800,300,800,300]);
                        
                    figure('Name','Segment Spectrum MDPK0/SA1.wav_AA');
                    specsegOrig_phAA = abs(fft(segOrig_phAA(indRowMDPK0_SA1,1:200)));
                    specSegFiltphAA = abs(fft(segFiltphAA(indRowMDPK0_SA1,1:200)));
                    f = FsIn * (1:200)/200;
                    plot(f,specsegOrig_phAA);
                    hold on;
                    plot(f,specSegFiltphAA);
                    xlabel('Frequency');
                    ylabel('P(f)')
                    legend('Original Waveform', 'Filtered Waveform');
                    hold off;
                    set(gcf,'position',[0,0,800,300]);

                        
                    figure('Name','Segment Spectrum MDPK0/SA1.wav_S');
                    specsegOrig_phS = abs(fft(segOrig_phS(indRowMDPK0_SA1,1:200)));
                    specSegFiltphS = abs(fft(segFiltphS(indRowMDPK0_SA1,1:200)));
                    f = FsIn * (1:200)/200;
                    plot(f,specsegOrig_phS);
                    hold on;
                    plot(f,specSegFiltphS);
                    xlabel('Frequency');
                    ylabel('P(f)')
                    legend('Original Waveform', 'Filtered Waveform');
                    hold off;
                    set(gcf,'position',[800,0,800,300]);
                end
                indRowMDPK0_SA1 = indRowMDPK0_SA1 + 1;
            end
            
            segOrig_phAA = segOrig_phAA ./ max(abs(segOrig_phAA));
            segFiltphAA = segFiltphAA ./ max(abs(segFiltphAA));
            segOrig_phS = segOrig_phS ./ max(abs(segOrig_phS));
            segFiltphS = segFiltphS ./ max(abs(segFiltphS));
            
            save('segAllData.mat',"segOrig_phAA","segFiltphAA","segOrig_phS","segFiltphS");

load('segAllData.mat');
            
% convert frequency to index
ind1A = round(width(segOrig_phAA)*(0.4/8.0));
ind2A = round(width(segOrig_phAA)*(1.6/8.0));
ind1B = round(width(segOrig_phAA)*(2.4/8.0));
ind2B = round(width(segOrig_phAA)*(4.0/8.0));
            
% DFT, calculate region A
for indRow = 1:height(segOrig_phAA)
    XAA = abs(fft(segOrig_phAA(indRow,[1:width(segOrig_phAA)])));
    [enRegAB_orig_phAA(indRow,1)] = 10*log10(aveEnFn(ind1A, ind2A, XAA));
end
for indRow = 1:height(segOrig_phS)
    XS = abs(fft(segOrig_phS(indRow,[1:width(segOrig_phS)])));
end
            
% region B
for indRow = 1:height(segOrig_phAA)
    AA = abs(fft(segOrig_phAA(indRow,[1:width(segOrig_phAA)])));
    [enRegAB_orig_phAA(indRow,2)] = 10*log10(aveEnFn(ind1B, ind2B, XAA));
end
for indRow = 1:height(segOrig_phS)
    XS = abs(fft(segOrig_phS(indRow,[1:width(segOrig_phS)])));
    [enRegAB_orig_phS(indRow,2)] = 10*log10(aveEnFn(ind1B, ind2B, XS));
end
            
% histogram AA
figure('Name','enRegAB_orig_phAA');
histogram(enRegAB_orig_phAA((1:height(enRegAB_orig_phAA)),1),15);
hold on; histogram(enRegAB_orig_phAA((1:height(enRegAB_orig_phAA)),2),15);
hold off;
xlabel('aveEn(dB)');
legend('Region A', 'Region B');
            
% histogram S
figure('Name','enRegAB_orig_phS');
histogram(enRegAB_orig_phS((1:height(enRegAB_orig_phS)),1),15);
hold on; histogram(enRegAB_orig_phS((1:height(enRegAB_orig_phS)),2),15);
hold off;
xlabel('aveEn(dB)');
legend('Region A', 'Region B');
            
save('aveEnAllData.mat',"enRegAB_orig_phAA","enRegAB_orig_phS");

function[aveEn] = aveEnFn(ind1, ind2, X)
    aveEn = 0;
    for k = ind1:ind2
    aveEn = aveEn + (X(1,k)^2/(ind2-ind1+1));
    end
end
%}