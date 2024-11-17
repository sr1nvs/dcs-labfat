clc;
clear all;
close all;
m = [1 0 1 0 1 0 1 0];
N = length(m);

duration = N; 
t = 0:0.01:duration; 

m_s = zeros(1, length(t));
nrz = zeros(1, length(t));
rz = zeros(1, length(t)); 
bp_nrz = zeros(1,length(t));
manchester = zeros(1,length(t));
ami = zeros(1,length(t));
polar_nrz = zeros(1,length(t));


for i = 1:N
    if m(i) == 1
        m_s((i-1)*100 + 1:i*100) = 1;
        nrz((i-1)*100 + 1:i*100) = 0;
        rz((i-1)*100 + 1:(i-1)*100 + 50) = 1; 
    else
        m_s((i-1)*100 + 1:i*100) = 0;
        nrz((i-1)*100 + 1:i*100) = 1; 
        rz((i-1)*100 + 1:(i-1)*100 + 50) = 0; 
    end
end

count=0;
r=0;
for i=1:N
    if m(i) == 1
        count=count+1;
        r=rem(count,2);
        if r==1
            bp_nrz((i-1)*100 + 1:i*100)=1;
            ami((i-1)*100 + 1:(i-1)*100 + 50)=1;
        else
            bp_nrz((i-1)*100 + 1:i*100)=-1;
            ami((i-1)*100 + 1:(i-1)*100 + 50)=-1;
        end
    else
        bp_nrz((i-1)*100 + 1:i*100)=0;
    end
end

for i = 0:N-1
  if m(i+1) == 1
    manchester(i*100+1:(i+0.5)*100) = 1;
    manchester((i+0.5)*100+1:(i+1)*100) = -1;
  else
    manchester(i*100+1:(i+0.5)*100) = -1;
    manchester((i+0.5)*100+1:(i+1)*100) = 1;
  end
end

for i = 1:2:N-1
    bit_pair = m(i:i+1);
    if isequal(bit_pair, [0 0])
        polar_nrz((i-1)*100 + 1:(i+1)*100) = -1.5;
    elseif isequal(bit_pair, [0 1])
        polar_nrz((i-1)*100 + 1:(i+1)*100) = -0.5;
    elseif isequal(bit_pair, [1 0])
        polar_nrz((i-1)*100 + 1:(i+1)*100) = 0.5;
    elseif isequal(bit_pair, [1 1])
        polar_nrz((i-1)*100 + 1:(i+1)*100) = 1.5;
    end
end

figure(1);
stairs(t, m_s, 'linewidth', 2);
set(gca,'fontsize',12,'fontweight','bold');
xlabel('Time','FontSize',12,'FontWeight','bold');
ylabel('Amplitude','FontSize',14,'FontWeight','bold');
title('Input', 'LineWidth', 2);
ylim([-0.5 1.5]);
grid on;

figure(2);
subplot(3,2,1);
plot(t, nrz, 'LineWidth', 2);
set(gca,'fontsize',12,'fontweight','bold');
xlabel('Time','FontSize',12,'FontWeight','bold');
ylabel('Amplitude','FontSize',12,'FontWeight','bold');
title(' Unipolar NRZ', 'LineWidth', 2);
ylim([-0.5 1.5]);
grid on;

subplot(3,2,2);
plot(t, rz, 'LineWidth', 2);
set(gca,'fontsize',12,'fontweight','bold');
xlabel('Time','FontSize',12,'FontWeight','bold');
ylabel('Amplitude','FontSize',12,'FontWeight','bold');
title('Unipolar RZ', 'LineWidth', 2);
ylim([-0.5 1.5]);
grid on;

subplot(3,2,3);
plot(t, bp_nrz, 'LineWidth', 2);
set(gca,'fontsize',12,'fontweight','bold');
xlabel('Time','FontSize',12,'FontWeight','bold');
ylabel('Amplitude','FontSize',12,'FontWeight','bold');
title('Bipolar NRZ', 'LineWidth', 2);
ylim([-1.5 1.5]);
grid on;

subplot(3,2,4);
plot(t, ami, 'LineWidth', 2);
set(gca,'fontsize',12,'fontweight','bold');
xlabel('Time','FontSize',12,'FontWeight','bold');
ylabel('Amplitude','FontSize',12,'FontWeight','bold');
title('Bipolar RZ - AMI', 'LineWidth', 2);
ylim([-1.5 1.5]);
grid on;

subplot(3,2,5);
plot(t, manchester, 'LineWidth', 2);
set(gca,'fontsize',12,'fontweight','bold');
xlabel('Time','FontSize',12,'FontWeight','bold');
ylabel('Amplitude','FontSize',12,'FontWeight','bold');
title('Manchester', 'LineWidth', 2);
ylim([-1.5 1.5]);
grid on;

subplot(3,2,6)
plot(t, polar_nrz, 'LineWidth', 2);
set(gca,'fontsize',12,'fontweight','bold');
xlabel('Time','FontSize',12,'FontWeight','bold');
ylabel('Amplitude','FontSize',12,'FontWeight','bold');
title('Polar Quaternary NRZ', 'LineWidth', 2);
ylim([-2 2]);
grid on;