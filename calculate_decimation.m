function signal_out=calculate_decimation(signal_in,fs,nfs)
fcutpb=nfs/2-5;
fcutsb=nfs/2+5;
ripple_pb=(1.01-0.9)/2;
ripple_sb=(1.01-0.9)/2;
HB_filter=0.001;
FIRL_Coeff=calculatesfir(fcutsb,fcutpb,ripple_pb,ripple_sb,HB_filter,fs,'low');%calculates a low pass filter
figure(2);
freqz(FIRL_Coeff,1);
title('Decimation filter');
signal_ = filter(FIRL_Coeff,1,signal_in);
factor=(fs/nfs);
lengthy=length(signal_in);
lengthy=lengthy/factor;
lengthy=fix(lengthy);
ilengthy=cast(lengthy,'uint16');
for i = 1:ilengthy
    x=cast(fix((i)*factor),'uint16');
signal_out(i)=signal_(x);
end
end