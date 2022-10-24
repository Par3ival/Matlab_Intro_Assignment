function [] = caseD_GausPDF()
%CASED_GAUSPDF This module will calculate the energy values of the 
%              extracted region calculated from using Gaussian Probability
%              Density Function (PDF)             
%{
%=========================================================================%
 @details Order of operation:
                - Use previously read list data (enOrigRegAB)
                - Perform gaussian PDF calculation for each phoneme 
                  ('aa' and 's') and each region (A and B)
                - Divide the gaussian formula into two parts (first and
                  second)
                - Save the data into p (for each phoneme and region)
%=========================================================================%
%}


    % Perform nested function to reduce duplicated code
    function p = gaus(enOrigRegAB,zone)
    % we define x as the energy value that we will calculate in the
    % Gaussian PDF
    x = sort(enOrigRegAB(:,zone));     % sorts the elements of enOrigRegAb in ascending order
    mu = mean(x);                      % mean value of x
    sigma = sqrt(var(x));              % variance value of x
    f = exp(-0.5*(((x-mu)/sigma).^2)); % 2nd half of gaussian equation
    denom = sqrt(2*pi*sigma^2);        % 1st half of gaussian equation
    p = {x,f/denom};                   % store values for plotting
    end

                 

%  Load the energy value data from the current list entry
enAllData = load("enAllData.mat");

% Perform gaussian PDF calculation for phoneme ('aa') in region A
pAA_A = gaus(enAllData.enOrigRegAB_phAA,1);
% Perform gaussian PDF calculation for phoneme ('aa') in region B
pAA_B = gaus(enAllData.enOrigRegAB_phAA,2);
% Perform gaussian PDF calculation for phoneme ('s') in region A
pS_A = gaus(enAllData.enOrigRegAB_phS,1);
% Perform gaussian PDF calculation for phoneme ('s') in region B
pS_B = gaus(enAllData.enOrigRegAB_phS,2);

% We are going to display the  modelling of energy values graph using Gaussan PDF
% in one figure consisted of 4 parts
tiledlayout(2,2);
% first part is we display the energy modelling of 'aa' in Zone A
nexttile;
plot(pAA_A{1},pAA_A{2})
title('Energy Value Modelling of ''aa'' in Zone A');
xlabel('Energy/dB');
ylabel('Gauss Distribution');
hold on;
% second part is we display the energy modelling of 'aa' in Zone B
nexttile;
plot(pAA_B{1},pAA_B{2})
title('Energy Value Modelling of ''aa'' in Zone B');
xlabel('Energy/dB');
ylabel('Gauss Distribution');
hold on;
% third part is we display the energy modelling of 's' in Zone A
nexttile;
plot(pS_A{1},pS_A{2})
title('Energy Value Modelling of ''s'' in Zone A');
xlabel('Energy/dB');
ylabel('Gauss Distribution');
hold on;
% last part is we display the energy modelling of 's' in Zone B
nexttile;
plot(pS_B{1},pS_B{2})
title('Energy Value Modelling of ''s'' in Zone B');
xlabel('Energy/dB');
ylabel('Gauss Distribution');
hold on;

end

