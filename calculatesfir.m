function fir=calculatesfir(fcutsb,fcutpb,ripple_pb,ripple_sb,HB_filter,fs,ftype)
%%%%%%%%%FreqN%%%%%%%
ohcutpb=(fcutpb*2*pi)*(1/fs);
ohcutsb=(fcutsb*2*pi)*(1/fs);
Wn=fcutpb+(fcutsb-fcutpb)/2;
Wn=Wn/(fs/2);
%%%%%%%%%%%%%%%%%%%%%%
Length_TW=ohcutsb-ohcutpb;%calculate bw
Min_ripple=min([ripple_pb,ripple_sb,HB_filter]);%discover max atenuation
order=20*log10(Min_ripple);%calculater firter order
%%%%%%%%%%%WindMinorSizeCalculation%%%%%%
MK=-(-order-8)/(2.285*Length_TW);
wind=MK;
filter="MK";
MR=0;
MB=0;
Mh=0;
MH=0;
MBl=0;
if(order>-21)
    MR=(4*pi/Length_TW-1);
    wind=MR;
    filter="MR";
end
    if(order>-25)
         MB=(4*pi/Length_TW);
         if(MB<wind)
           wind=MB;
            filter="Mb";
         end
    end
        if(order>-44)
             Mh=(4*pi/Length_TW);
             if(Mh<wind)
           wind=Mh;
            filter="Mh";
         end
        end
            if(order>-53)
                 MH=(4*pi/Length_TW);
                     if(MH<wind)
                        wind=MH;
                         filter="MH";
         end
            end
                 if(order>-74)
                      MBl=(12*pi/Length_TW);
                           if(MBl<wind)
                            wind=MBl;
                            filter="MBL";
                            end
                 end
                 wind=ceil(-wind);
%%%%%%%%%%%%%%%%%%%CalculatesWindFIRTominorwsize%%%%%%%%%%%%%%
 switch(filter)
     case 'MK'
      if(wind>=21)
                 beta=0.5842*(wind - 21)^0.4 + 0.07886*(wind - 21);
        end
         if(wind>50)
             beta=0.1102*(wind - 8.7) ;
           end
            if(wind<21)
                beta=0;      
             end
          b = fir1(wind,Wn,ftype,kaiser(ceil(wind)+1,beta));
          case 'MR'
              b = fir1(wind,Wn,ftype,rectwin(ceil(wind)+1));
            case 'Mb'
                 b = fir1(wind,Wn,ftype,bartlett(ceil(wind)+1));
               case 'Mh'
                    b = fir1(wind,Wn,ftype,hann(ceil(wind)+1));
                   case 'MH'
                       b = fir1(wind,Wn,ftype,hamming(ceil(wind)+1));
                         case 'MBL'
                              b = fir1(wind,Wn,ftype,blackman(ceil(wind)+1));
 end
 fir=b;
end