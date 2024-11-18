clc;
clear;
close all;

% Parameters
Tb = 1; 
fc = 10;
t = 0:Tb/100:1;
c = sqrt(2/Tb) * sin(2 * pi * fc * t);

% Message Signal
N = 8;
m = [1 0 1 0 1 0 1 0];
t1 = 0; 
t2 = Tb;

for i = 1:N
    t = t1:0.01:t2;
    m_s = ones(1, length(t)) * (m(i) > 0.5); % Generate message signal (1 or 0)
    message(i, :) = m_s;
    ask_sig(i, :) = c .* m_s; % ASK signal
    
    % Plotting
    figure(1);
    subplot(5, 1, 2); 
    axis([0 N -1 2]);
    plot(t, message(i, :), 'b', 'LineWidth', 2);
    title('Message Signal');
    xlabel('t'); ylabel('m(t)');
    grid on;
    set(gca, 'FontSize', 12, 'FontWeight', 'bold')
    hold on;
    
    subplot(5, 1, 4); 
    plot(t, ask_sig(i, :), 'b', 'LineWidth', 2);
    title('ASK Signal');
    xlabel('t'); ylabel('s(t)');
    grid on;
    set(gca, 'FontSize', 12, 'FontWeight', 'bold')
    hold on;
    
    t1 = t1 + (Tb);
    t2 = t2 + (Tb);
end
hold off;

subplot(5, 1, 3); 
plot(t, c, 'b', 'LineWidth', 2);
title('Carrier Signal');
xlabel('t'); ylabel('c(t)');
set(gca, 'FontSize', 12, 'FontWeight', 'bold')
grid on;

subplot(5, 1, 1); 
stem(m, 'b', 'LineWidth', 2);
title('Binary Data Bits');
xlabel('n'); ylabel('b(n)');
set(gca, 'FontSize', 12, 'FontWeight', 'bold')
grid on;

% ASK Demodulation
t1 = 0; 
t2 = Tb;

for i = 1:N
    t = t1:Tb/100:t2;
    x = sum(c .* ask_sig(i, :));
    demod(i) = (x > 0); % Demodulation logic
    t1 = t1 + (Tb);
    t2 = t2 + (Tb);
end

subplot(5, 1, 5);
stem(demod, 'b', 'LineWidth', 2);
title('ASK Demodulated Signal');
xlabel('n'); ylabel('b(n)');
set(gca, 'FontSize', 12, 'FontWeight', 'bold')
grid on;