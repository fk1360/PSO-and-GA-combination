realizedays;

IC=3200*Nw+2000*Npv+100*Nb;
MC=100*Nw+33*Npv+5*Nb;
RC=100*Nb;
LCC=IC+MC+RC;

aLPSP=0;bLPSP=0;
for i=1:24
    pindx=PL(i)-(Pw(i)+Ppv(i)+SOCb(i));
    if (pindx<0)
        pindx=0;
    end
    aLPSP=aLPSP+pindx;
    bLPSP=bLPSP+PL(i);
end
fLPSP=aLPSP/bLPSP*100;

