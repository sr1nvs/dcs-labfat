clc
clear all
close all

binary_in = [1 0 0 0];

seq = zeros(1,2^(length(binary_in))-1);
n = length(seq);

for i=1:n
    y = xor(binary_in(1), binary_in(4));
    seq(i) = binary_in(4);
    for j = 4:-1:2
        binary_in(j) = binary_in(j-1);
    end
    binary_in(1) = y;
end

disp(binary_in);
disp(seq);
stem(seq, 'linewidth', 2); title("PN Sequence");
xlabel("Sample Index"); ylabel("Value"); xlim([0 16]);
set(gca, 'fontsize', 11, 'fontweight', 'bold')
