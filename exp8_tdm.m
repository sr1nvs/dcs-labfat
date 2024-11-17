clc 
clear all
close all

nc = 8*pi;
x=0:.1:nc;
sig1=8*sin(x);
sig2=8*sawtooth(x, 1/2);
sig3=8*square(x);
l=length(sig1);

figure(2);
subplot(3,1,1);
plot(sig1, 'r','LineWidth',2);
title('Sinusoidal Signal');
ylabel('Amplitude');
xlabel('Time'); xlim([0 length(x)]);
set(gca, 'fontsize', 11, 'FontWeight', 'bold')

subplot(3,1,2);
plot(sig2, 'g', 'LineWidth',2);
title('Triangular Signal');
ylabel('Amplitude');
xlabel('Time'); xlim([0 length(x)]);
set(gca, 'fontsize', 11, 'FontWeight', 'bold')

subplot(3,1,3);
plot(sig3, 'b', 'LineWidth',2);
title('Square Signal');
ylabel('Amplitude');
xlabel('Time'); xlim([0 length(x)]);
set(gca, 'fontsize', 11, 'FontWeight', 'bold')

 for i=1:l
  sig(1,i)=sig1(i);                        
  sig(2,i)=sig2(i);
  sig(3,i)=sig3(i);
 end  

tdmsig=reshape(sig,1,3*l);               

figure(3);
stem(tdmsig);
title('TDM Signal');
ylabel('Amplitude');
xlabel('Time'); xlim([0 3*length(x)]);
set(gca, 'fontsize', 11, 'FontWeight', 'bold')


% Demultiplexing of TDM Signal
 demux=reshape(tdmsig,3,l);
 for i=1:l
  sig4(i)=demux(1,i);                    
  sig5(i)=demux(2,i);
  sig6(i)=demux(3,i);
 end  
 
 figure(4);
 subplot(3,1,1)
 plot(sig4, 'r', 'LineWidth',2);
 title('Recovered Sinusoidal Signal');
 ylabel('Amplitude');
 xlabel('Time'); xlim([0 length(x)]);
 set(gca, 'fontsize', 11, 'FontWeight', 'bold')

 subplot(3,1,2)
 plot(sig5, 'g', 'LineWidth',2);
 title('Recovered Triangular Signal');
 ylabel('Amplitude');
 xlabel('Time'); xlim([0 length(x)]);
 set(gca, 'fontsize', 11, 'FontWeight', 'bold')

 subplot(3,1,3)
 plot(sig6, 'b', 'LineWidth',2);
 title('Recovered Square Signal');
 ylabel('Amplitude');
 xlabel('Time'); xlim([0 length(x)]);
 set(gca, 'fontsize', 11, 'FontWeight', 'bold')

 
 
 
 