function u = p_loss(in)
global Highway Obstacle
global UavTeam
global theta gcount2



M = UavTeam.AvailableNumMax;
V1 = [];
V2 = [];
for k=1:M
    if rand>theta || gcount2<=4*50+1
        UavTeam.Uav(k).Pes_o=in(2*(k-1)*M+1:2*k*M);
        UavTeam.Uav(k).Ves_o=in(2*M*M+2*(k-1)*M+1:2*M*M+2*k*M);
    end
end


for k=1:M
    V1=[V1;UavTeam.Uav(k).Pes_o];
    V2=[V2;UavTeam.Uav(k).Ves_o];
end
u=[V1;V2];

    