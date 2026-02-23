clc, clear, close all

acc_string = importdata("1.dat");
acc_cell = char(acc_string);

g = strfind(acc_cell,'*');
t = str2double(acc_cell(g(1)+1:g(2)-1));

acc_cell = acc_cell(g(end)+1:end);
 
acc_cell = strrep(acc_cell,'(',',');
acc_cell = erase(acc_cell,')');
m = strfind(acc_cell,',');

ACC = zeros(length(m)/3-1,3);
for i = 1:length(m)/3-1
    for j = 1:3
        ACC(i,j) = str2double(acc_cell(m(i*3+j-3)+1:m(i*3+j-2)-1));
    end
end
fs = size(ACC,1)/t;
time = 1/fs:1/fs:t;

[b,a] = butter(4,1/(1+1.0),"low");
ACC_filt = filtfilt(b,a,ACC);

figure(1)
plot(time,ACC_filt)
legend("X","Y","Z")
title("Acceleration Data")
xlabel("Time (s)")
ylabel("Acceleration (m/s^2)")


clear g i j m t acc_cell b a 
    


