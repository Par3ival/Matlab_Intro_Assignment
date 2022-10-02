%{
%=========================================================================%
 @name Introductory Module Lab Assignment
 @Date 30/09/22 (Original)
       01/10/22 (Last Updated)

 @details This module handles the text based UI and directing to the
          relevant function to handle the user request. 
%=========================================================================%
%}
%=========================================================================%
clc
clear
close all
%=========================================================================%
disp("=============================================================");
disp("Welcome to Group 1's Data Processing Program") ;
disp("=============================================================");
disp('Press a => FIR Filter ');
disp('Press b => Extract Samples from a Provided Audio File (.wav)');
disp('Press c => Calculate the Energy in the Regions Found by b');
disp('Press d => Model the Energy Values Using A Gaussian PDF');
disp('Press e => exit program');
disp("=============================================================");

strResponse = input('Chose an option from the above list: ', 's');

while (strcmp(strResponse,'e')~=1)
    switch (strResponse)
        %Perform FIR Filtering on listData.txt
        case 'a'
            clc
            disp("=============================================================");
            disp('Press a => Overlayed graphs ');
            disp('Press b => Tiled graphs (Separate)');
            disp('Press   => Selecting nothing will ignore graph generation');
            disp("=============================================================");
            strResponseGraph = input('Please input graphing choice: ', 's');
            listDataStruct = caseA_FIR('listData.txt', strResponseGraph);
        
        %Extract Segments of 'aa' and 's' from a .wav file
        case 'b'
            caseB_Segs();

        %Calculate the energy in a specified frequency region. Specified
        %via case b.
        case 'c'
            caseC_Energy();

        % Model the energy values using Gaus PDF
        case 'd'
            caseD_GausPDF();

        otherwise
            disp('Invalid choice, please make a selection from the list');
    end
    clc
    disp("=============================================================");
    disp("Please Reselect an Option From the List") ;
    previousChoice = ['Previous Choice:  ', strResponse];
    disp(previousChoice);
    disp("=============================================================");
    disp('Press a => FIR Filter ');
    disp('Press b => Extract Samples from a Provided Audio File (.wav)');
    disp('Press c => Calculate the Energy in the Regions Found by b');
    disp('Press d => Model the Energy Values Using A Gaussian PDF');
    disp('Press e => exit program');
    disp("=============================================================");

    strResponse = input('Chose an option from the above list: ', 's');
end
clc



%=========================================================================%