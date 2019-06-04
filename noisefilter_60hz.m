function y1=noisefilter_60hz(SIGNAL,fs)
subplot(4,1,1);
plot(SIGNAL);
title('60hz noise remove Imput Signal');
%%%%FFT%%%%
L=length(SIGNAL);
f = fs*(0:(L/2))/L;
Y=fft(SIGNAL);
P2 = abs(Y/L);
P1 = P2(1:L/2+1);
P1(2:end-1) = 2*P1(2:end-1);
subplot(4,1,2);
plot(f,P1)
title('Signal fft');
%%%%%%%NotchFilter%%%%%%%
wo = 60/(200/2);  bw = wo/35;
[b,a] = iirnotch(wo,bw);
%%%%%%FilterSignal%%%%
y1 = filter(b,a,SIGNAL);
subplot(4,1,3);
plot(y1);
%%%%FFT%%%%
L=length(y1);
f = fs*(0:(L/2))/L;
Y=fft(y1);
P2 = abs(Y/L);
P1 = P2(1:L/2+1);
P1(2:end-1) = 2*P1(2:end-1);
subplot(4,1,4);
plot(f,P1)
title('Signal fft');
fvtool(b,a);
zplane(b,a)
grid
end