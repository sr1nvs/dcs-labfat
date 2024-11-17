clc;
clear;
close all;

fm = 10; % Frequency
n = 8; % No. of bits 
A = 1;  % Amplitude
t = 0:0.001:1;  % Time vector
x = A * cos(2 * pi * fm * t);  % Original signal

% Sampling
fs = 10 * fm;  % Sampling frequency
ts = 0:1/fs:1;  % Time vector
xs = A * cos(2 * pi * fm * ts);  % Sampled signal

% Quantization
x1 = xs + A;  % Shifting the signal to make it positive
x1 = x1 / (2 * A);  % Normalizing the signal to range [0, 1]
L = (2^n) - 1;  % Number of quantization levels
x1 = L * x1;  % Mapping to quantization levels
xq = round(x1);  % Quantized values

% Encoding
y = [];  % Initialize encoded signal array
for i = 1:length(xq)
    d = dec2bin(xq(i), n);  % Convert to binary
    y = [y, double(d) - 48];  % Convert characters to numbers and append
end

% Plotting
figure(1);
plot(t, x, 'LineWidth', 2); hold on;
stem(ts, xs, 'r', 'LineWidth', 2); hold off;
title('Original and Sampled Signal');
xlabel('Time');
ylabel('Amplitude');
legend('Original signal', 'Sampled signal');
set(gca, 'FontSize', 12, 'FontWeight', 'bold');

figure(2);
stem(ts, x1 / L * (2 * A) - A, "LineWidth", 2); hold on;
stem(ts, xq / L * (2 * A) - A, 'r', 'LineWidth', 2);
plot(ts, xq / L * (2 * A) - A, '-k'); 
hold off;
title('Quantization');
xlabel('Samples');
ylabel('Amplitude');
legend('Sampled signal', 'Quantized signal');
set(gca, 'FontSize', 12, 'FontWeight', 'bold');

figure(3);
stairs(y, 'LineWidth', 2);
title('Encoded Waveform');
xlabel('Bits');
ylabel('Binary Signal');
ylim([-1 2]);
grid on;
set(gca, 'FontSize', 12, 'FontWeight', 'bold');