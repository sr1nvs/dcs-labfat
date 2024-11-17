clc
clear all
close all

binaryin = [1 0 0 0];

seq = zeros(1,2^(length(binaryin)-1));
n = length(seq);

for i=1:15
    y = xor(binaryin(1), binaryin(4));
    seq(i) = binaryin(4);
    for j = 4:-1:2
        binaryin(j) = binaryin(j-1);
    end
    binaryin(1) = y;
end

disp(binaryin);
disp(seq);
stem(seq, 'linewidth', 2); title("PN Sequence");
xlabel("Sample Index"); ylabel("Value"); xlim([0 16]);
set(gca, 'fontsize', 11, 'fontweight', 'bold')
