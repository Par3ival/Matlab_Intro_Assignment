function [] = caseA_FIR(listTextFileIn, graphicalOutput)
%CASEA_FIR This function will filter a series of input .wav files.
%{
%=========================================================================%
 @details Order of operation:
                - Load in listData.txt
                - Use read in data to find and loop through every .wav file
                - Load in a original .wav file from wavOrigin into a matrix
                - Perform FIR filtering on the matrix
                        - x(n) input --> y(n) FIR filtered output
                        - Samples should be the same number across in-out
                        - x(n) before time 0 (n <= 0) are considered 0.
%=========================================================================%
%}
%=========================================================================%
% Path Setup
%=========================================================================%

% Open the list file containing our .wav locations
% First define the path to the downloadable folder
folderPath = '\dataTIMIT_labAssign2022_usedToStud\dataTIMIT_labAssign2022_usedToStud\';
% Next find the users current path
mainPath = pwd;
fullPath = append(mainPath, folderPath);
% Finally append the paths and requested file name together
fullFileName = append(fullPath,listTextFileIn);

% Open and store errMSG for confirming status to user.
[fileID, errorMSG] = fopen(fullFileName,'rt');
disp(errorMSG);

index = 1;

inputFileList(index).FilePath = fscanf(fileID, '%s', 1);

% For use later
extension = '.wav';
originalWavPath = 'wavOrig\';
filteredWavPath = 'wavFilt\';
comparisonPath = 'MCPM0\SA1';

%=========================================================================%
% FIR Magnitude Frequency Response Graph
%=========================================================================%
%  Define the FIR filter coefficients
firCoef = [-0.8, 0.24, 0.4, 0.4, 0.16, -0.24, 0.08];
impulse_appended = [firCoef zeros(1,249)];
nCoef = length(firCoef);

FIR_FFT = fft(impulse_appended);
FIR_FFT_ABS =  abs(FIR_FFT);
% Remove the offset (1st Value)
FIR_FFT_ABS = FIR_FFT_ABS(2:end);
% Remove the conjugates (Mirror)
FFT_Half_Length = (length(FIR_FFT_ABS)-1)/2;
FIR_FFT_ABS_Half = FIR_FFT_ABS(1:FFT_Half_Length);

% Get Magnitude through 20log
FIR_FFT_Magnitude = 20*log(FIR_FFT_ABS_Half);

% Calculate the frequency scale (Fs/N)*k ( K is the x scale)!
% Sample frequency of our filter is 20kHz
Frequency_Scale = 20e3 / length(FIR_FFT);

% Plot shows a high pass
figure('Name','Frequency Response');
plot(FIR_FFT_Magnitude);
drawnow
title('Magnitude Frequency Response Of FIR Filter')
grid;
xlabel('Frequency Index');
ylabel('Magnitude (dB)');

%=========================================================================%
% Audio File Filtering Loop
%=========================================================================%

% This will loop through the entire file. Every 1 loop is a .wav calc
while (strcmp(inputFileList(index).FilePath,'.')~=1)

    %  Load the input signal from the current list entry.
    fileName = inputFileList(index).FilePath;
    fileName = append(fullPath,originalWavPath,fileName,extension);
    [inpSigWav,Fs] = audioread(fileName);
    %nSamples = length(inpSigWav);

    %  Add zero samples to the beginning and to the end of the input signal to
    %  take account of the filter length
    inpSigWavExt = [zeros(nCoef-1,1); inpSigWav; zeros(nCoef-1,1)];
    nSamplesNew = length(inpSigWavExt);

    %  Allocate memory for the output signal
    outSigWav = zeros(nSamplesNew,1);
    %  Perform filtering (note that the indexing in Matlab is from 1)
    for i=nCoef:nSamplesNew,
        outSigWav(i) = firCoef(1)*inpSigWavExt(i)+firCoef(2)*inpSigWavExt(i-1);
    end

    %  Store the output signal into .wav file
    fileNameOut = append(fullPath,filteredWavPath,inputFileList(index).FilePath,extension);
    audiowrite(fileNameOut, outSigWav, Fs);

    if strcmp(inputFileList(index).FilePath, comparisonPath)
        % We are going to display the original and filtered wave forms
        figure('Name','Waveform Comparison');

        if strcmp(graphicalOutput, 'a')
            % User wanted an overlayed layout
            plot(1900:2300,inpSigWav(1900:2300),'g',1900:2300,outSigWav(1900:2300),'b');
            drawnow
            title('SA1 Original and Filtered Signals Overlayed');
            xlabel('Sample Index');
            ylabel('Amplitude');
            legend('Input signal', 'Output signal')
        end

        if  strcmp(graphicalOutput, 'b')
            % User wanted a tiled layout
            tiledlayout(2,1);

            nexttile;
            plot(1900:2300,inpSigWav(1900:2300));
            drawnow
            title('Original Waveform for SA1.wav');
            xlabel('Sample Index');
            ylabel('Amplitude');
            grid;

            nexttile;
            plot(1900:2300,outSigWav(1900:2300));
            drawnow
            title('Filtered Waveform for SA1.wav');
            xlabel('Sample Index');
            ylabel('Amplitude');
            grid;
        end
    end

    % This file has been read, move to next path.
    index = index + 1;
    inputFileList(index).FilePath = fscanf(fileID, '%s', 1);

end

