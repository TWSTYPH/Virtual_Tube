function u = inf_esti_o(in)
global Highway Obstacle
global UavTeam 
% persistent Pos1 Pos2 Vel1 Vel2
% if isempty(Pos1)
%     Pos1 = UavTeam.Uav(1).HomePos;
% end
% if isempty(Pos2)
%     Pos2 = UavTeam.Uav(2).HomePos;
% end
% if isempty(Vel1)
%     Vel1 = in(5:6);
% end
% if isempty(Vel2)
%     Vel2 = in(7:8);
% end
M = UavTeam.AvailableNumMax;

V1 = [];
Pes =  in(1:2*M);
Ves =  in(2*M+1: 4*M);
% Pos1 = mysat(in(1:2)-Pos1,Ts*vbp)+Pos1;
% Pos2  = mysat(in(3:4)-Pos2,Ts*vbp)+Pos2;
% Vel1  = mysat(in(5:6)-Vel1,Ts*vbp)+Vel1;
% Vel2 = mysat(in(7:8)-Vel2,Ts*vbp)+Vel2;
% random noise

    for j = 1:M
% %         ro_el = UavTeam.Noise.bl*rand;%
% %         theta_el = 2*pi*rand;%
% %         el_p = ro_el*cos(theta_el);
% %         el_v = ro_el*sin(theta_el);
% %         ro_el_p = el_p*rand;%
% %         ro_el_v = el_v*rand;%
% %         theta_el_p=2*pi*rand;%
% %         theta_el_v=2*pi*rand;%
% %         el_p_x = ro_el_p*cos(theta_el_p);
% %         el_p_y = ro_el_p*sin(theta_el_p);
% %         el_v_x = ro_el_v*cos(theta_el_p);
% %         el_v_y = ro_el_v*sin(theta_el_p);
%         
        a=[2*j-1,2*j];
        V1=[V1;Pes(a);Ves(a)];
% %         V2=[V2;Ves(a)];
    end
%     UavTeam.Uav(1).Pes = Pos1;
%     UavTeam.Uav(1).Ves = Vel1;
%     UavTeam.Uav(2).Pes = Pos2;
%     UavTeam.Uav(2).Ves = Vel2;
u=V1;
