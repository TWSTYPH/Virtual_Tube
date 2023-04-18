function u = collisioncon(in)
global Highway Obstacle
global UavTeam
global gcount gfigure gcount2
gcount = gcount + 1;
gcount2= gcount2+1;

M = UavTeam.AvailableNumMax;
V = [];

for k=1:M
    UavTeam.Uav(k).PesO=in(4*(k-1)+1:4*(k-1)+2);
    UavTeam.Uav(k).VesO=in(4*(k-1)+3:4*k);
end
% for k=1:M
%     UavTeam.Uav(k).PosE_O=in(4*M+4*(k-1)+1:4*M+4*(k-1)+2);
%     UavTeam.Uav(k).VelE_O=in(4*M+4*(k-1)+3:4*M+4*k);
% end
% for j = 1 : size(Obstacle)
% Obstacle(j).Center = Obstacle(j).Center + Obstacle(j).gain;   
% end

for k = 1:M
%     % Velocity control command
%       Pcur                      =  UavTeam.Uav(k).PesE;
%       Vcur                      =  UavTeam.Uav(k).VelE;
%       Pdes                      =  UavTeam.Uav(k).Waypoint(:,UavTeam.Uav(k).CurrentTaskNum);
   UavTeam.Uav(k).VelocityCom   =  mycontrol(k);
    
    % Collect all the control
     V  = [V;UavTeam.Uav(k).VelocityCom];

     % plot online
     if gcount>=500
        figure(1);
    
         hold off
         MyMap(UavTeam,Obstacle,Highway);

     end
end

if gcount>=500
gcount = 0;
gfigure = gfigure+1;
t = in(end)
end

u =V;
