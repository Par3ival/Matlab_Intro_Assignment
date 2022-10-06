function [] = caseD_GausPDF()

    function p = gaus(enOrigRegAB,zone)
    x = sort(enOrigRegAB(:,zone));
    mu = mean(x);
    sigma = sqrt(var(x));
    f = exp(-0.5*(((x-mu)/sigma).^2));
    denom = sqrt(2*pi*sigma^2);
    p = {x,f/denom};
    end

enAllData = load("enAllData.mat");

pAA_A = gaus(enAllData.enOrigRegAB_phAA,1);
pAA_B = gaus(enAllData.enOrigRegAB_phAA,2);
pS_A = gaus(enAllData.enOrigRegAB_phS,1);
pS_B = gaus(enAllData.enOrigRegAB_phS,2);

tiledlayout(2,2);
nexttile;
plot(pAA_A{1},pAA_A{2})
nexttile;
plot(pAA_B{1},pAA_B{2})
nexttile;
plot(pS_A{1},pS_A{2})
nexttile;
plot(pS_B{1},pS_B{2})

end

