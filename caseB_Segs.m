function [segOrig_phS, segOrig_phAA] = caseB_Segs(inputFileList)
%CASEB_SEGS This module will remove specified Phonemes from input .wav
%           files.
%{
%=========================================================================%
 @details Order of operation:
                - Use previously read list data
                - For each .wav file search the relevant .lab (label file)
                  for rows containing specified phonemes
                - Extract the relevant start/end times for that phoneme
                - Calculate the centre time of that sample
                - Calculate the centre time in samples
                - Using the calculated centre sample time, sample 25ms
                  around that central time.
                - Save the data into segOrig_phAA or segOrig_phS
%=========================================================================%
%}

%=========================================================================%
% Path Setup
%=========================================================================%

% % First define the path to the downloadable folder
folderPath = '/dataTIMIT_labAssign2022_usedToStud/dataTIMIT_labAssign2022_usedToStud/';
% % Next find the users current path and append
fullPath = append(pwd,folderPath);

% For use later
extension = '.wav';
labext = '.lab';
originalWavPath = 'wavOrig/';
phonemePath = 'labels/';
segOrig_phS_index = 1;
segOrig_phAA_index = 1;
file_index = 1;
comparePath = 'MCPM0/SA1';
firstCompare = 0;

%=========================================================================%
% Signal Sampling Loops
%=========================================================================%

% This will loop through the entire file. Every 1 loop is a .wav calc
while (strcmp(inputFileList(file_index).FilePath,'.')~=1)

    %  Load the input signal from the current list entry.
    fileName_wav = inputFileList(file_index).FilePath;
    fileName_wav = append(fullPath,originalWavPath,fileName_wav,extension);
    [inpSigWav,Fs] = audioread(fileName_wav);

    %  Load the LAB file from the current list entry.
    fileName_lab = inputFileList(file_index).FilePath;
    fileName_lab = append(fullPath,phonemePath,fileName_lab,labext);

    % Create struct |starttime|endtime|phoneme| and filter out 'aa' and 's'
    phonemeStruct = lab_array(fileName_lab);
    struct_aa = phonemeStruct(strcmp({phonemeStruct.phoneme}, 'aa'));
    struct_s = phonemeStruct(strcmp({phonemeStruct.phoneme}, 's'));

    % All occurences of 's' and corresponding samples into array
    for s = struct_s
        timePhStart = (s.start)/10^4;
        timePhEnd = (s.end)/10^4;
        timeSegStart_ms = timePhStart + (timePhEnd - timePhStart)/2 - 12.5;
        sample_index = round(Fs*[timeSegStart_ms timeSegStart_ms+25]/10^3);
        segOrig_phS(segOrig_phS_index,:) = inpSigWav(sample_index(1):sample_index(2));
        segOrig_phS_index = segOrig_phS_index + 1;
    end

    % All occurences of 'aa' and corresponding samples into array
    for aa = struct_aa
        timePhStart = (aa.start)/10^4;
        timePhEnd = (aa.end)/10^4;
        timeSegStart_ms = timePhStart + (timePhEnd - timePhStart)/2 - 12.5;
        sample_index = (Fs*[timeSegStart_ms timeSegStart_ms+25]/10^3);
        segOrig_phAA(segOrig_phAA_index,:) = inpSigWav(sample_index(1):sample_index(2));
        segOrig_phAA_index = segOrig_phAA_index + 1;
    end

    if (strcmp(comparePath,inputFileList(file_index).FilePath) == 1) && (firstCompare == 0)
        tiledlayout(2,1);
        nexttile;

        %Plot the first AA and S of SA1.wav
        plot(segOrig_phAA(1,:));
        drawnow
        title('First Occurance of Phoneme AA in SA1.wav');
        xlabel('Sample Index');
        ylabel('Amplitude');
        grid;

        nexttile;

        plot(segOrig_phS(1,:));
        drawnow
        title('First Occurance of Phoneme S in SA1.wav');
        xlabel('Sample Index');
        ylabel('Amplitude');
        grid;
        firstCompare = 1;
    end
        % This file has been read, move to next path.
    file_index = file_index + 1;
end

save('segAllData.mat', "segOrig_phS","segOrig_phAA")
end

