function [segOrig_phS, segOrig_phAA] = caseB_Segs(listTextFileIn)
%CASEB_SEGS Summary of this function goes here
%   Detailed explanation goes here

%=========================================================================%
% Path Setup
%=========================================================================%

% Open the list file containing our .wav locations
% First define the path to the downloadable folder

folderPath = '/dataTIMIT_labAssign2022_usedToStud/dataTIMIT_labAssign2022_usedToStud/';
fullPath = append(pwd,folderPath);
fullFileName = append(fullPath, listTextFileIn);

% Open and store errMSG for confirming status to user.
[fileID, errorMSG] = fopen(fullFileName,'rt');
disp(errorMSG);

% For use later
extension = '.wav';
labext = '.lab';
originalWavPath = 'wavOrig/';
phonemePath = 'labels/';
segOrig_phS_index = 1;
segOrig_phAA_index = 1;
file_index = 1;

inputFileList(file_index).FilePath = fscanf(fileID, '%s', 1);

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
        timePhStart = s.start;
        timePhEnd = s.end;
        timeSegStart_ms = timePhStart + (timePhEnd - timePhStart)/2 - 12.5;
        sample_index = round(Fs*[timeSegStart_ms timeSegStart_ms+25e4]/10e6);
        segOrig_phS(segOrig_phS_index,:) = inpSigWav(sample_index(1):sample_index(2));
        segOrig_phS_index = segOrig_phS_index + 1;
    end

    % All occurences of 'aa' and corresponding samples into array
    for aa = struct_aa
        timePhStart = aa.start;
        timePhEnd = aa.end;
        timeSegStart_ms = timePhStart + (timePhEnd - timePhStart)/2 - 12.5;
        sample_index = round(Fs*[timeSegStart_ms timeSegStart_ms+25e4]/10e6);
        segOrig_phAA(segOrig_phAA_index,:) = inpSigWav(sample_index(1):sample_index(2));
        segOrig_phAA_index = segOrig_phAA_index + 1;
    end
      
    % This file has been read, move to next path.
    file_index = file_index + 1;
    inputFileList(file_index).FilePath = fscanf(fileID, '%s', 1);

end

