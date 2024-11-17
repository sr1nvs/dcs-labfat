clc;
clear;
close all;

% Parameters
fm = 10; % Frequency
n = 8; % Number of bits 
A = 1;  % Amplitude
t = 0:0.001:1;  % Time vector for continuous signal
x = A * cos(2 * pi * fm * t);  % Original signal

% Sampling
fs = 100 * fm;  % Sampling frequency
ts = 0:1/fs:1;  % Time vector for sampled signal
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

% Demodulation (Decoding)
decoded = zeros(1, length(xq));  % Initialize decoded array
index = 1; 
for i = 1:n:length(y)  % Increment by n bits each time
    bits = y(i:i+n-1);  % Extract the corresponding n bits
    decoded(index) = bin2dec(num2str(bits));  % Convert binary to decimal
    index = index + 1;  % Move to the next position in decoded array
end

decoded = (decoded / L) * (2 * A) - A;  % Rescale decoded values


% Plotting
figure;

% Subplot 1: Original Signal
subplot(5, 1, 1);
plot(t, x, 'LineWidth', 2);
title('Original Signal');
xlabel('Time');
ylabel('Amplitude');
set(gca, 'FontSize', 12, 'FontWeight', 'bold');
grid on;

% Subplot 2: Sampled Signal
subplot(5, 1, 2);
stem(ts, xs, 'r', 'LineWidth', 2);
title('Sampled Signal');
xlabel('Time');
ylabel('Amplitude');
set(gca, 'FontSize', 12, 'FontWeight', 'bold');
grid on;

% Subplot 3: Quantized Signal
subplot(5, 1, 3);
stem(ts, xq / L * (2 * A) - A, 'r', 'LineWidth', 2); hold on;
plot(ts, xq / L * (2 * A) - A, '-k', 'LineWidth', 1.5); 
hold off;
title('Quantized Signal');
xlabel('Samples');
ylabel('Amplitude');
set(gca, 'FontSize', 12, 'FontWeight', 'bold');
grid on;

% Subplot 4: Encoded Signal
subplot(5, 1, 4);
stairs(y, 'LineWidth', 2);
title('Encoded Signal');
xlabel('Bits');
ylabel('Binary Signal');
ylim([-1 2]);
set(gca, 'FontSize', 12, 'FontWeight', 'bold');
grid on;

% Subplot 5: Demodulated Signal
subplot(5, 1, 5);
stem(ts, decoded, 'g', 'LineWidth', 2);
title('Demodulated Signal');
xlabel('Samples');
ylabel('Amplitude');
set(gca, 'FontSize', 12, 'FontWeight', 'bold');
grid on;
