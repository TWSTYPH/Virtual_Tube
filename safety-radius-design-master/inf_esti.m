function u = inf_esti(in)
global UavTeam
global ex vbp vbv Ts
% global ep_x ep_y ev_x ev_y
M = UavTeam.AvailableNumMax;
ex=0;

V1=[];
V2=[];

for k = 1:M
    UavTeam.Uav(k).CurrentPos =  in(2*(k-1)+1:2*k);
    UavTeam.Uav(k).Velocity   =  in(2*M+2*(k-1)+1: 2*M+2*k);
end
a = UavTeam.Uav(1).CurrentPos;

for k = 1:M
    Pcur =  UavTeam.Uav(k).CurrentPos;
    Vcur =  UavTeam.Uav(k).Velocity;

% random noise
    ro_ep = UavTeam.Noise.bp*rand;%
    ro_ev = UavTeam.Noise.bv*rand;%
    
    theta_ep = 2*pi*rand;%
    theta_ev = 2*pi*rand;%
    
    ep_x1 = ro_ep*cos(theta_ep);
    ep_y1 = ro_ep*sin(theta_ep);
    ev_x1 = ro_ev*cos(theta_ev);
    ev_y1 = ro_ev*sin(theta_ev);
    Pes= Pcur+UavTeam.Uav(k).PE + mysat([ep_x1 ep_y1]'-UavTeam.Uav(k).PE,Ts*vbp);
    Ves= Vcur +UavTeam.Uav(k).VE+ mysat([ev_x1 ev_y1]'-UavTeam.Uav(k).VE,Ts*vbv);
     UavTeam.Uav(k).Pes =Pes;
     
     UavTeam.Uav(k).Ves =Ves;
%     UavTeam.Uav(k).Pes = mysat(Pes- UavTeam.Uav(k).Pes,Ts*vbp)+ Pcur;
%     UavTeam.Uav(k).Ves = mysat(Ves- UavTeam.Uav(k).Ves,Ts*vbv)+ Vcur;
% %     UavTeam.Uav(k).ksie = Pes+1/UavTeam.gain*Ves
    V1=[V1;Pes];
    V2=[V2;Ves];
end

u=[V1;V2];