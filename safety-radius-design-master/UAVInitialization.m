function UavTeam = UAVInitialization(M,rm)
% Initialize UAV

global   Obstacle
global bp bv bl loss_rate rv taod vm Ts
% global ep_x ep_y ev_x ev_y
% The number of UAVs
UavTeam.AvailableNumMax  = M;
UavTeam.Ts               = Ts;
UavTeam.gain             = 5;
UavTeam.Noise.bp = bp;
UavTeam.Noise.bv = bv;
UavTeam.Noise.bl = bl;
UavTeam.PacketLossRate=loss_rate;

vm = 0;
rv = 0;
r_distribute = 400;

L=UavTeam.gain;
% Distances between among waypoints and obstacles have to be greater than a
% value. So SavedWPOB is defined to save current waypoints and obstacles for distance check.
sz   =  size(Obstacle);

% Write down the waypoint
for k = 1: UavTeam.AvailableNumMax
    
    UavTeam.Uav(k).Waypoint = [];
           UavTeam.Uav(k).r = rm;
%            UavTeam.Uav(k).vmax = 5+(k-1)*5 ;
UavTeam.Uav(1).vmax = 5;
UavTeam.Uav(2).vmax = 3;
UavTeam.Uav(3).vmax = 4;
UavTeam.Uav(4).vmax = 5;
%            UavTeam.Uav(k).rs = rs;
%            UavTeam.Uav(k).ra = ra;
           UavTeam.Uav(k).rv = UavTeam.Uav(k).vmax/L;
           if UavTeam.Uav(k).rv>rv
               rv=UavTeam.Uav(k).rv;
           end
           rv=2;
           if UavTeam.Uav(k).vmax>vm
               vm=UavTeam.Uav(k).vmax;
           end

    % Home waypoint
    % Let it in obstacle, moreover they are close to each other. This is
    % used to test our control method
%               theata = 2*pi*rand;
%                rx    = rand*Obstacle(1).r*cos(theata);
%                ry    = rand*Obstacle(1).r*sin(theata);

    UavTeam.Uav(1).HomePos = [-40 40]';
    UavTeam.Uav(2).HomePos = [40 40]';
    UavTeam.Uav(3).HomePos = [40 -40]';
    UavTeam.Uav(4).HomePos = [-40 -40]';
          UavTeam.Uav(k).Waypoint = [UavTeam.Uav(k).Waypoint UavTeam.Uav(k).HomePos];
        UavTeam.Uav(k).CurrentPos =  UavTeam.Uav(k).HomePos;

      % Destination waypoint 
         temp =-UavTeam.Uav(k).HomePos;
         UavTeam.Uav(k).Waypoint = [UavTeam.Uav(k).Waypoint temp];
         
         
         
             ro_ep = bp*rand;%
    ro_ev = bv*rand;%
    
    theta_ep = 2*pi*rand;%
    theta_ev = 2*pi*rand;%
    
    ep_x = ro_ep*cos(theta_ep);
    ep_y = ro_ep*sin(theta_ep);
    ev_x = ro_ev*cos(theta_ev);
    ev_y = ro_ev*sin(theta_ev);
    
    
%     UavTeam.Uav(k).Pes = UavTeam.Uav(k).HomePos+ [ep_x ep_y]';
%     UavTeam.Uav(k).Ves = [0 0]'+ [ev_x ev_y]';
%     UavTeam.Uav(k).PE=UavTeam.Uav(k).Pes-UavTeam.Uav(k).HomePos;
%     UavTeam.Uav(k).VE=UavTeam.Uav(k).Ves;
        UavTeam.Uav(k).Pes = UavTeam.Uav(k).HomePos;
    UavTeam.Uav(k).Ves = [0 0]';
    UavTeam.Uav(k).PE=UavTeam.Uav(k).Pes-UavTeam.Uav(k).HomePos;
    UavTeam.Uav(k).VE=UavTeam.Uav(k).Ves;
       %  Current task number
          UavTeam.Uav(k).CurrentTaskNum = 2;
          UavTeam.Uav(k).AllTaskNum     = 2;
       % Velocity
       UavTeam.Uav(k).Velocity = zeros(2,1);


end
UavTeam.AllHomePos= [] ;   
% for k =1: M
%     UavTeam.AllHomePos = [UavTeam.AllHomePos;UavTeam.Uav(k).HomePos];
% end
for k =1: M
    UavTeam.AllHomePos = [UavTeam.AllHomePos;UavTeam.Uav(k).HomePos;0;0];
end