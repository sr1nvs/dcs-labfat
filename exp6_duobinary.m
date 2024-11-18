clc
clear all
close all

b = [1 0 1 0 1 0 1 0];
n = length(b);
a = zeros(1, n+1);

a(1) = 1;

for i = 2:n+1
    a(i) = xor(a(i-1), b(i-1));
end

precoding = zeros(1,n+1);

for i=1:n+1
    if a(i)==0
        precoding(i)=-1;
    end 
    if a(i)==1
        precoding(i)=1;
    end 
end    

duobinary_seq = zeros(1,n);

for i=1:n
    duobinary_seq(i) = precoding(i) + precoding(i+1);
end

seq_out = zeros(1,n);

for i=1:n
    if duobinary_seq(i)==0
        seq_out(i) = 1;
    end  
    if duobinary_seq(i)==2||duobinary_seq(i)==-2
        seq_out(i) = 0;
        
    end
end

disp('Binary Sequence {bk} ');
disp(b);
disp('Binary Sequence {ak}');
disp(a);
disp('Precoder Output');
disp(precoding);
disp('Duobinary Coder Output {ck} ');
disp(duobinary_seq);
disp('Sequence Obtained by Decision Rule {bk} ');
disp(seq_out);

figure;

subplot(4, 1, 1); 
stem(b, 'LineWidth', 2); 
title('Binary Sequence {bk}');
xlabel('Sample Index');
ylabel('Value');
ylim([0, 1]);
set(gca, 'fontsize', 12, 'fontweight', 'bold');
grid on;

subplot(4, 1, 2);
stairs(a(1:n), 'LineWidth', 2); 
title('Binary Sequence {ak}');
xlabel('Sample Index');
ylabel('Value');
ylim([0, 1]);
set(gca, 'fontsize', 12, 'fontweight', 'bold');
grid on;

subplot(4, 1, 3);
stairs(duobinary_seq, 'LineWidth', 2); 
title('Duobinary Coder Output {ck} ');
xlabel('Sample Index');
ylabel('Value');
ylim([-2, 2]);
set(gca, 'fontsize', 12, 'fontweight', 'bold');
grid on;


subplot(4, 1, 4);
stem(seq_out, 'LineWidth', 2);
title('Sequence Obtained by Decision Rule {bk} ');
xlabel('Sample Index');
ylabel('Value');
ylim([0, 1]);
set(gca, 'fontsize', 12, 'fontweight', 'bold');
grid on;

