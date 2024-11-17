clc;
clear;
close all;

% Parameters
Tb = 1;
t = 0:Tb/100:Tb;
fc = 2;
c1 = sqrt(2/Tb) * cos(2 * pi * fc * t);
c2 = sqrt(2/Tb) * cos(2 * pi * fc * t + pi);

% Message Signal
N = 8;
m = [1 0 1 0 1 0 1 0];
t1 = 0; 
t2 = Tb;

for i = 1:N
    t = t1:(Tb/100):t2;
    if m(i) > 0.5
        m_s = ones(1, length(t));
        invm_s = zeros(1, length(t));
    else
        m_s = zeros(1, length(t));
        invm_s = ones(1, length(t));
    end
    message(i, :) = m_s;
    
    % Generate PSK Signal
    psk_sig1(i, :) = c1 .* m_s;
    psk_sig2(i, :) = c2 .* invm_s;
    psk_s = psk_sig1 + psk_sig2;
    
    % Plotting
    figure(1);
    subplot(3, 2, 2);
    axis([0 N -2 2]);
    plot(t, message(i, :), 'b', 'LineWidth', 2);
    title('Message Signal');
    xlabel('t'); ylabel('s(t)');
    grid on;
    set(gca, 'FontSize', 12, 'FontWeight', 'bold');
    hold on;
    
    subplot(3, 2, 5);
    plot(t, psk_s(i, :), 'b', 'LineWidth', 2);
    title('PSK Signal');
    xlabel('t'); ylabel('s(t)');
    grid on;
    set(gca, 'FontSize', 12, 'FontWeight', 'bold');
    hold on;
    
    t1 = t1 + (Tb + 0.01);
    t2 = t2 + (Tb + 0.01);
end
hold off;

subplot(3, 2, 1);
stem(m, 'b', 'LineWidth', 2);
title('Binary Data');
xlabel('n'); ylabel('b(n)');
grid on;
set(gca, 'FontSize', 12, 'FontWeight', 'bold');

subplot(3, 2, 3);
plot(t, c1, 'b', 'LineWidth', 2);
title('Carrier Signal 1');
xlabel('t'); ylabel('c1(t)');
grid on;
set(gca, 'FontSize', 12, 'FontWeight', 'bold');

subplot(3, 2, 4);
plot(t, c2, 'b', 'LineWidth', 2);
title('Carrier Signal 2');
xlabel('t'); ylabel('c2(t)');
grid on;
set(gca, 'FontSize', 12, 'FontWeight', 'bold');

% PSK Demodulation
t1 = 0; 
t2 = Tb;

for i = 1:N
    t = t1:(Tb/100):t2;
    
    % Correlator
    x1 = sum(c1 .* psk_sig1(i, :));
    x2 = sum(c2 .* psk_sig2(i, :));
    x = x1 - x2;
    
    % Decision Device
    if x > 0
        demod(i) = 1;
    else
        demod(i) = 0;
    end
    
    t1 = t1 + (Tb + 0.01);
    t2 = t2 + (Tb + 0.01);
end

% Plotting the Demodulated Data Bits
subplot(3, 2, 6);
stem(demod, 'b', 'LineWidth', 2);
title('Demodulated Data');
xlabel('n'); ylabel('b(n)');
grid on;
set(gca, 'FontSize', 12, 'FontWeight', 'bold');
