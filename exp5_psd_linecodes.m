clc;

Rb=1;                                                        
Tb=1/Rb;                       
V=1;
f=0:Rb/100:3*Rb;
fTb=f*Tb;                        


up_nrz = ((V^2)/4)*Tb*(sinc(fTb).^2)+((V^2)/4)*dirac(f);  
p_nrz=(V^2)*Tb*(sinc(fTb).^2); 
bp_nrz=(V^2)*Tb*(sinc(fTb)).*(sinc(fTb)).*(sin(pi*fTb)).*(sin(pi*fTb));     
manchester=(V^2)*Tb*(sinc(fTb/2)).*(sinc(fTb/2)).*(sin(pi*fTb/2)).*(sin(pi*fTb/2));


plot(f, bp_nrz, 'linewidth', 4);
hold on;

plot(f, up_nrz, 'linewidth', 4);
set(gca, 'fontsize',12, 'fontweight','bold');

plot(f, manchester, 'linewidth', 4);
set(gca,'fontsize',12, 'fontweight','bold');

plot(f, p_nrz, 'linewidth', 4);
set(gca,'fontsize',12, 'fontweight','bold');

legend('Bipolar NRZ','Unipolar NRZ','Manchester','Polar NRZ');
xlabel('Frequency');
ylabel('Power Spectral Density');
title('PSD of Binary Line Codes');