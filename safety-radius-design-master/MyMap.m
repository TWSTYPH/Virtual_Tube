function out = MyMap(UavTeam,Obstacle,Highway)

global gcount E rs ro_s
M = UavTeam.AvailableNumMax;

grid on


subplot(1,1,1)
for k = 1: M
    o1 = UavTeam.Uav(k).CurrentPos;
    o2 = UavTeam.Uav(k).CurrentPos+1/UavTeam.gain*UavTeam.Uav(k).Velocity;
    mydrawcolorball(o1,o2,k);  
    if k ==1
    p1 = UavTeam.Uav(k).Pes;
    p2 = UavTeam.Uav(k).Pes+1/UavTeam.gain*UavTeam.Uav(k).Ves;
        mycircle_dotted(p2,rs);

else
    p3 = UavTeam.Uav(k).PesO;
    p4 = UavTeam.Uav(k).PesO+1/UavTeam.gain*UavTeam.Uav(k).VesO;
        mycircle_dotted(p4,ro_s);
    end

% mydrawcolorball(p1,p2,k);
end

hold off
xlabel('Positions without uncertainties')


axis([-40 40 -40 40]) 

% subplot(3,1,2)
% for k = 1: M
% if k ==1
%     o1 = UavTeam.Uav(k).Pes;
%     o2 = UavTeam.Uav(k).Pes+1/UavTeam.gain*UavTeam.Uav(k).Ves;
% else
%     o1 = UavTeam.Uav(k).PesO;
%     o2 = UavTeam.Uav(k).PesO+1/UavTeam.gain*UavTeam.Uav(k).VesO;
% end
% 
%     mydrawcolorball(o1,o2,k);  
% %     mycircle_dotted(o2,rs);
% end
% hold off
% xlabel('View of UAV1')
% axis([-80 80 -60 60]) 
% 
% subplot(3,1,3)
% for k = 1: M
% if k ==2
%     o1 = UavTeam.Uav(k).Pes;
%     o2 = UavTeam.Uav(k).Pes+1/UavTeam.gain*UavTeam.Uav(k).Ves;
% else
%     o1 = UavTeam.Uav(k).PesO;
%     o2 = UavTeam.Uav(k).PesO+1/UavTeam.gain*UavTeam.Uav(k).VesO;
% end
% 
%     mydrawcolorball(o1,o2,k);  
%     mycircle_dotted(o2,rs);
% end
% xlabel('View of UAV2')
% axis([-80 80 -60 60])
out = 0;