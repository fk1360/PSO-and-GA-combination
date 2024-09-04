clear all;
fLPSP_goal=10; %percent
mutate_rate=20; %percent
N=100;w=0.8;c1=2;c2=2;beta=2;T=50;

V0=10;
        
%initial value set
for partindx=1:N
    while true 
        particles_x(partindx,:)=200.*rand([1 3]);
        particles_v(partindx,:)=V0.*rand([1 3]);
        particles_xp(partindx,:)=particles_x(partindx,:);
        if(particles_x(partindx,1)<0)
            particles_x(partindx,1)=0;
        end
        if(particles_x(partindx,2)<0)
            particles_x(partindx,2)=0;
        end
        if(particles_x(partindx,3)<0)
            particles_x(partindx,3)=0;
        end
        Nw=floor(particles_x(partindx,1));
        Nb=floor(particles_x(partindx,2));
        Npv=floor(particles_x(partindx,3));
        simulation;
        particles_price(partindx)=LCC;
        if (fLPSP<fLPSP_goal)
            particles_xp_price(partindx)=LCC;
            break;
        end
    end
    if(partindx==1)
        price_best(1)=LCC;
        particles_xg=particles_x(partindx,:);
    elseif(LCC<price_best(1))
        price_best(1)=LCC;
        particles_xg=particles_x(partindx,:);
    end
end

%Main run of iterations
for itern = 1:T
    price_best(itern+1)=price_best(itern);
    for partindx=1:N
        particles_v(partindx,:)=w.*particles_v(partindx,:)+c1*rand().*(particles_xp(partindx,:)-particles_x(partindx,:))+c2*rand().*(particles_xg-particles_x(partindx,:));
        particles_x(partindx,:)=particles_x(partindx,:)+particles_v(partindx,:);
        if(particles_x(partindx,1)<0)
            particles_x(partindx,1)=0;
        end
        if(particles_x(partindx,2)<0)
            particles_x(partindx,2)=0;
        end
        if(particles_x(partindx,3)<0)
            particles_x(partindx,3)=0;
        end
        Nw=floor(particles_x(partindx,1));
        Nb=floor(particles_x(partindx,2));
        Npv=floor(particles_x(partindx,3));
        simulation;
        particles_price(partindx)=LCC;
        if (fLPSP<fLPSP_goal)
            fLPSP=fLPSP_goal;
        end
        if (LCC<particles_xp_price(partindx) && fLPSP==fLPSP_goal)
            particles_xp(partindx,:)=particles_x(partindx,:);
            particles_xp_price(partindx)=LCC;
        end
        if (LCC<price_best(itern+1) && fLPSP==fLPSP_goal)
            particles_xg=particles_x(partindx,:);
            price_best(itern+1)=LCC;
        end
    end
    pso_mutate;
    itern
end
Nw=floor(particles_xg(1));
Nb=floor(particles_xg(2));
Npv=floor(particles_xg(3));
[Nw,Nb,Npv]
price_best(T+1)
figure(1)
% main_1_test_accuracy;
% figure(2)
plot(price_best)



