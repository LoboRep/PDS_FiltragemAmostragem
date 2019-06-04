%%%%%%LoadSIgnal%%%%
fileID = fopen("D:\TrabalhoPDS\ECG_HFN.dat",'r');
SIGNAL=fscanf(fileID,' %f');
fclose(fileID);
figure (1);
subplot(5,1,1);
plot(SIGNAL);
title('System Imput Signal');
%%%%%%Parameters%%%%
fs=200;
flcutpb=70;
flcutsb=75;
lripple_pb=(1.01-0.9)/2;
lripple_sb=(1.01-0.9)/2;
lHB_filter=0.001;
%%%%FFT%%%%
L=length(SIGNAL);
f = fs*(0:(L/2))/L;
Y=fft(SIGNAL);
P2 = abs(Y/L);
P1 = P2(1:L/2+1);
P1(2:end-1) = 2*P1(2:end-1);
subplot(5,1,2);
plot(f,P1)
title('Signal in fft');
%%%%%%CalcFIRSmallOrder%%%%
FIRL_Coeff=calculatesfir(flcutsb,flcutpb,lripple_pb,lripple_sb,lHB_filter,fs,'low');
%%%%%%CutoffFreq%%%%
figure(3);
freqz(FIRL_Coeff,1);
title('Low Pass Filter');
%%%%%%FilterSignal%%%%
y1 = filter(FIRL_Coeff,1,SIGNAL);
figure (1);
subplot(5,1,3);
plot(y1);
title('Signal after  Low Pass Filter');
figure(2);
y2=noisefilter_60hz(y1,fs);

%%%%FFT%%%%
figure (1);
L=length(SIGNAL);
f = fs*(0:(L/2))/L;
Y=fft(y2);
P2 = abs(Y/L);
P1 = P2(1:L/2+1);
P1(2:end-1) = 2*P1(2:end-1);
subplot(5,1,4);
plot(f,P1)
title('System signal out fft');
subplot(5,1,5);
plot(y2);
title('system out signal');