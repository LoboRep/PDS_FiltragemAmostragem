%%%%%%LoadSIgnal%%%%
fileID = fopen("D:\TrabalhoPDS\ECG_LFN.dat",'r');
SIGNAL=fscanf(fileID,' %f');
fclose(fileID);
figure (1);
subplot(2,1,1);
plot(SIGNAL);
title('Imput Signal');
fs=200;
%%%%FFT%%%%
figure (2);
L=length(SIGNAL);
f = fs*(0:(L/2))/L;
Y=fft(SIGNAL);
P2 = abs(Y/L);
P1 = P2(1:L/2+1);
P1(2:end-1) = 2*P1(2:end-1);
subplot(2,1,1);
plot(f,P1)
title('Imput Signal fft');

%%%%%%Parameters%%%%
flcutpb=0.1;
flcutsb=1.0;
ripple_pb=1; %%dB
ripple_sb=60; %%dB
%%%%%%CalcIIR%%%%
W_lcutpb=(2*flcutpb/200);
W_lcutsb=(2*flcutsb/200);
[order, Wlcut] = buttord (W_lcutpb,W_lcutsb,ripple_pb,ripple_sb);
[z,p,k] = butter(order,Wlcut);
figure (3);
sos = zp2sos(z,p,k);
freqz(sos,1028,fs);
[b,a] = butter(order,Wlcut, 'high');
freqz(b,a)
fvtool(b,a);
zplane(b,a)
grid
%%%%%%FilterSignal%%%%
figure (1);
y1 = filter(b,a,SIGNAL);
subplot(2,1,2);
plot(y1);
title('Signal filtered');
%%%%FFT%%%%
figure (2);
L=length(y1);
f = fs*(0:(L/2))/L;
Y=fft(y1);
P2 = abs(Y/L);
P1 = P2(1:L/2+1);
P1(2:end-1) = 2*P1(2:end-1);
subplot(2,1,2);
plot(f,P1)
title('Signal filtered fft');