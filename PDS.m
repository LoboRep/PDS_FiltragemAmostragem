fileID = fopen("D:\TrabalhoPDS\ECG_LFN.dat",'r');
SIGNAL=fscanf(fileID,' %f');
fclose(fileID);
figure (1);
plot(SIGNAL);
fs=200;
fcutpb=20;
fcutsb=30;
ripple_pb=(1.01-0.9)/2;
ripple_sb=(1.01-0.9)/2;
HB_filter=0.001;
order=calculatesfir(fcutsb,fcutpb,ripple_pb,ripple_sb,HB_filter,fs);
ohcut=fcutpb+((fcutsb-fcutpb)/2);
ohcut=ohcut*2*(1/fs);
FIRL_Coeff = fir1(order, ohcut, 'low');
figure (2);
freqz(FIRL_Coeff,1);
y1 = filter(FIRL_Coeff,1,SIGNAL);
%y1= SIGNAL-y1;
figure (3);
plot(y1);
%%%%FFT%%%%
figure (4);
L=9519;
f = fs*(0:(L/2))/L;
Y=fft(y1);
P2 = abs(Y/L);
P1 = P2(1:L/2+1);
P1(2:end-1) = 2*P1(2:end-1);
plot(f,P1)
%%%%FFT%%%%
ydecimated=calculate_decimation(y1,200,140);
figure (5);
plot(ydecimated);
factor=200/140;
figure (6);
plot(ydecimmatl);