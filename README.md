# Matlab_Intro_Assignment
Introductory Matlab Assignment for Birmingham Uni Masters. 
Date: September 2022

This repo is for aggregating tests, programs and results that have been carried out by The Buoys.

1. [User Selection a: FIR Filtering of .wav Files](#section-a---fir-filtering-wav-files)
    - Last Updated 01/10/2022
    - Last Changed By: DTB
2. [User Selection b: Extracting Phoneme's From .wav Files](#section-b---extracting-phonemes-from-wav-files)
    - Last Updated NA
    - Last Changed By: NA
3. [User Selection c: Finding the Average Energy In Frequency Regions](#section-c---finding-average-energy-in-specified-frequency-regions)
    - Last Updated NA
    - Last Changed By: NA
4. [User Selection d: Model Energy Values Using A Gaussian Probability Density Function](#section-d---gaussian-probability-density-function)
    - Last Updated NA
    - Last Changed By: NA
5. [User Input Selection Interface](#section-e---text-based-user-interface)


## Section A - FIR Filtering WAV Files

This section of the project is covered by **`caseA_FIR.m`**. This function/module iterates through **`listData.txt`** row by row to find each .wav file and then perform the relevant filtering calculations using a pre-defined impulse response for the filter. The resulting, filtered, .wav files are then saved into a separate location wavFilt for later use by other sections of the project.

The user is also able to select what graphs they would like to view before starting the function. This allows for the selection of: an overlayed graph, tiled graphs or no output graphs. This is done to show to the user the effect of using the specified FIR filter on input signal **`MCPM0/SA1.wav`**. Along with this the function displays a magnitude frequency response curve to demonstrate visually the FIR filter in use.


## Section B - Extracting Phoneme's From WAV Files

## Section C - Finding Average Energy In Specified Frequency Regions

## Section D - Gaussian Probability Density Function

## Section E - Text Based User Interface


*Landing Text Interface*
```
=============================================================
Welcome to Group 1's Data Processing Program
=============================================================
Press a => FIR Filter 
Press b => Extract Samples from a Provided Audio File (.wav)
Press c => Calculate the Energy in the Regions Found by b
Press d => Model the Energy Values Using A Gaussian PDF
Press e => exit program
=============================================================
Chose an option from the above list: 
```

*FIR Selection Interface*
```
=============================================================
Press a => Overlayed graphs 
Press b => Tiled graphs (Separate)
Press   => Selecting nothing will ignore graph generation
=============================================================
Please input graphing choice: 
```

