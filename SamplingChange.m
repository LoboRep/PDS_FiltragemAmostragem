%%%%%%LoadSIgnal%%%%
fileID = fopen("D:\TrabalhoPDS\ECG_LFN.dat",'r');
SIGNAL=fscanf(fileID,' %f');
fclose(fileID);
figure (1);
subplot(3,1,1);
plot(SIGNAL);
title('Imput Signal');
fs=200;
%%%%%%ReSample%%%%%
y = resample(SIGNAL,280,200);%%upper sampling of freq
figure (1);
subplot(3,1,2);
plot(y)
title('Upsample');
%%%%%Decimation%%%%
signal_out=calculate_decimation(y,280,140);
figure (1);
subplot(3,1,3);
plot(signal_out);
title('Downsample');