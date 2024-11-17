%% ASK

clc;
clear all;
close all;

% Generate carrier
Tb=1; fc=10;
t=0:Tb/100:1;
c=sqrt(2/Tb)*sin(2*pi*fc*t);

% ASK

N=8;
m=[1 0 1 0 1 0 1 0];
t1=0;t2=Tb;
for i=1:N
 t=[t1:.01:t2];
 if m(i)>0.5
 m(i)=1;
 m_s=ones(1,length(t));
 else
 m(i)=0;
 m_s=zeros(1,length(t));
 end
 message(i,:)=m_s;

 ask_sig(i,:)=c.*m_s;
 t1=t1+(Tb+.01);
 t2=t2+(Tb+.01);
 
 figure(1);
 
 subplot(5,1,2);axis([0 N -2 2]);plot(t,message(i,:),'b');
 title('Message signal');xlabel('t');ylabel('m(t)');grid on
 hold on
 subplot(5,1,4);plot(t,ask_sig(i,:), 'b');
 title('ASK signal');xlabel('t');ylabel('s(t)');grid on
 hold on
 end
hold off

subplot(5,1,3);plot(t,c, 'b');
title('Carrier signal');xlabel('t');ylabel('c(t)');grid on
subplot(5,1,1);stem(m, 'b');
title('Binary data bits');xlabel('n');ylabel('b(n)');grid on


% ASK Demodulation
t1=0;t2=Tb;
 for i=1:N
 t=[t1:Tb/100:t2];
 
 x=sum(c.*ask_sig(i,:));
 
 if x>0
 demod(i)=1;
 else
 demod(i)=0;
 end
 t1=t1+(Tb+.01);
 t2=t2+(Tb+.01);
 end
 
 
 subplot(5,1,5);
 stem(demod, 'b');
 title('ASK Demodulated signal'); xlabel('n');ylabel('b(n)');grid on 


 %% FSK
% Carrier

Tb=1; fc1=2 ;fc2=10;
t=0:(Tb/100):Tb;
c1=sqrt(2/Tb)*cos(2*pi*fc1*t);
c2=sqrt(2/Tb)*cos(2*pi*fc2*t);


% Message
N=8;
m=[1 0 1 0 1 0 1 0];
t1=0;t2=Tb;
for i=1:N
 t=[t1:(Tb/100):t2];
 if m(i)>0.5
 m(i)=1;
 m_s=ones(1,length(t));
 invm_s=zeros(1,length(t));
 else
 m(i)=0;
 m_s=zeros(1,length(t));
 invm_s=ones(1,length(t));
 end
 message(i,:)=m_s;
 
 %Multiplier
 fsk_sig1(i,:)=c1.*m_s;
 fsk_sig2(i,:)=c2.*invm_s;
 fsk=fsk_sig1+fsk_sig2;
 
 figure(2);
 subplot(3,2,2);axis([0 N -2 2]);plot(t,message(i,:),'b');
 title('Message signal');xlabel('t');ylabel('m(t)');grid on;hold on;
 subplot(3,2,5);plot(t,fsk(i,:), 'b');
 title('FSK signal');xlabel('t');ylabel('s(t)');grid on;hold on;
 t1=t1+(Tb+.01); t2=t2+(Tb+.01);
 end
hold off

subplot(3,2,1);stem(m, 'b');
title('Binary data');xlabel('n'); ylabel('b(n)');grid on;
subplot(3,2,3);plot(t,c1, 'b');
title('Carrier signal-1');xlabel('t');ylabel('c1(t)');grid on;
subplot(3,2,4);plot(t,c2, 'b');
title('Carrier signal-2');xlabel('t');ylabel('c2(t)');grid on;

% FSK Demodulation
 t1=0;t2=Tb;
 for i=1:N
 t=[t1:(Tb/100):t2];
 
 %correlator
 x1=sum(c1.*fsk_sig1(i,:));
 x2=sum(c2.*fsk_sig2(i,:));
 x=x1-x2;
 %decision device
 if x>0
 demod(i)=1;
 else
 demod(i)=0;
 end
 t1=t1+(Tb+.01);
 t2=t2+(Tb+.01);
 end
 
 %Plotting the demodulated data bits
 subplot(3,2,6);stem(demod, 'b');
 title('Demodulated data');xlabel('n');ylabel('b(n)'); grid on; 
 
 
 %% PSK
 
Tb=1;
t=0:Tb/100:Tb;
fc=2;
c1=sqrt(2/Tb)*cos(2*pi*fc*t);
c2=sqrt(2/Tb)*cos(2*pi*fc*t + 180);

N=8;
m= [1 0 1 0 1 0 1 0];
t1=0;t2=Tb;
for i=1:N
 t=[t1:(Tb/100):t2];
 if m(i)>0.5
 m(i)=1;
 m_s=ones(1,length(t));
 invm_s=zeros(1,length(t));
 else
 m(i)=0;
 m_s=zeros(1,length(t));
 invm_s=ones(1,length(t));
 end
 message(i,:)=m_s;

 psk_sig1(i,:)=c1.*m_s;
 psk_sig2(i,:)=c2.*invm_s;
 psk=psk_sig1+psk_sig2;


 figure(3);
 subplot(3,2,2);
 axis([0 N -2 2]);
 plot(t,message(i,:),'b');
 title('Message signal');xlabel('t');ylabel('s(t)');grid on;hold on;
 
 subplot(3,2,5);
 plot(t,psk(i,:),'b');
 title('PSK signal');xlabel('t');ylabel('s(t)');grid on;hold on;
 t1=t1+(Tb+.01); t2=t2+(Tb+.01);
end
hold off

subplot(3,2,1);stem(m,'b');
title('Binary data');xlabel('n');ylabel('b(n)');
grid on;
subplot(3,2,3);plot(t,c1,'b');
title('Carrier signal 1');xlabel('t');ylabel('c1(t)');
subplot(3,2,4);plot(t,c2,'b');
title('Carrier signal 2');xlabel('t');ylabel('c2(t)');
grid on;

t1=0;t2=Tb;
 for i=1:N
 t= [t1:.01:t2];
 x1=sum(c1.*psk_sig1(i,:));
 x2=sum(c2.*psk_sig2(i,:));
 x = x1-x2;
 if x>0
 demod(i)=1;
 else
 demod(i)=0;
 end
 t1=t1+1.01;
 t2=t2+1.01;
 end

 subplot(3,2,6);stem(demod,'b');
 title('Demodulated data');xlabel('n');ylabel('b(n)');
 grid on 