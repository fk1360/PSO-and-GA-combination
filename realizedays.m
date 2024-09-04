systemdatas;
eta=1;
SOCmax=Nb;
SOCmin=0.05*SOCmax;
SOC(1)=SOCmin;
for days=1:100
    for i=1:24
        if (Ppv(i)+Pw(i)-PL(i)>0)
            if (SOCmax-SOC(i)<(Ppv(i)+Pw(i)-PL(i))*eta)
                SOC(i+1)=SOCmax;
            else
                SOC(i+1)=SOC(i)+(Ppv(i)+Pw(i)-PL(i))*eta;
            end
            SOCb(i)=(SOC(i)-SOC(i+1))/eta;
        else
            if (SOC(i)-SOCmin<(PL(i)-Ppv(i)-Pw(i))/eta)
                SOC(i+1)=SOCmin;
            else
                SOC(i+1)=SOC(i)-(PL(i)-Ppv(i)-Pw(i))/eta;
            end
            SOCb(i)=(SOC(i)-SOC(i+1))*eta;
        end
    end
    SOC(1)=SOC(25);
end
for i=1:24
    SOCm(i)=SOC(i+1);
end
