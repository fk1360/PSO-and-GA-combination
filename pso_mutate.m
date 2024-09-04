mutate_num=mutate_rate*N/100;
for iimm = 1:N
    index_is_worst(iimm) = 0;
end

for jjmm = 1:mutate_num
    worst_price = particles_price(1);
    new_worst_index = 1;
    while (index_is_worst(new_worst_index))
        new_worst_index = new_worst_index+1;
        worst_price = particles_price(new_worst_index);
    end
    for iimm = 1:N
        if (particles_price(iimm)>worst_price && ~index_is_worst(iimm))
            worst_price = particles_price(iimm);
            new_worst_index = iimm;
        end
    end
    index_is_worst(new_worst_index) = 1;
end

for iimm = 1:N
    if (index_is_worst(iimm))
        partindx = iimm;
        while true 
            particles_x(partindx,:)=20.*rand([1 3]);
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
            simulationcore;
            particles_price(partindx)=LCC;
            if (fLPSP<fLPSP_goal)
                particles_xp_price(partindx)=LCC;
                break;
            end
        end
    end
end


