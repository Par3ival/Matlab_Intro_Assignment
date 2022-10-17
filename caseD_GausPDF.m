function [] = caseD_GausPDF()

    % nested function to reduce duplicated code
    function p = gaus(enOrigRegAB,zone)
    x = sort(enOrigRegAB(:,zone));     % smallest to largest
    mu = mean(x);                      % mean of x????
    sigma = sqrt(var(x));              % variance of x????
    f = exp(-0.5*(((x-mu)/sigma).^2)); % 2nd half of gausian equation
    denom = sqrt(2*pi*sigma^2);        % 1st half of gausian equation
    p = {x,f/denom};                   % store values for plotting
    end

enAllData = load("enAllData.mat");

pAA_A = gaus(enAllData.enOrigRegAB_phAA,1);
pAA_B = gaus(enAllData.enOrigRegAB_phAA,2);
pS_A = gaus(enAllData.enOrigRegAB_phS,1);
pS_B = gaus(enAllData.enOrigRegAB_phS,2);

tiledlayout(2,2);
nexttile;
plot(pAA_A{1},pAA_A{2})
title('Energy Value Modelling of ''aa'' in Zone A');
xlabel('Energy/dB');
ylabel('Gauss Distribution');
hold on;
nexttile;
plot(pAA_B{1},pAA_B{2})
title('Energy Value Modelling of ''aa'' in Zone B');
xlabel('Energy/dB');
ylabel('Gauss Distribution');
hold on;
nexttile;
plot(pS_A{1},pS_A{2})
title('Energy Value Modelling of ''s'' in Zone A');
xlabel('Energy/dB');
ylabel('Gauss Distribution');
hold on;
nexttile;
plot(pS_B{1},pS_B{2})
title('Energy Value Modelling of ''s'' in Zone B');
xlabel('Energy/dB');
ylabel('Gauss Distribution');
hold on;

end

