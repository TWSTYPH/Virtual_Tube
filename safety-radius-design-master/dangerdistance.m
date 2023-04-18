function u = dangerdistance(in)

global Obstacle
global UavTeam

M     =  UavTeam.AvailableNumMax;
Pcur  = in(1:2*M);
Vcur  = in(2*M+1:4*M);
Pes =  in(4*M+1:6*M);
Ves =  in(6*M+1: 8*M);
ksiO= in(8*M+1: 12*M);

% Pcur_itself = in(4*M+1:6*M);
% Vcur_itself = in(6*M+1:8*M);


% Minimum distance among UAVs
mindism_p = 100000;
for i=1:M
    for j = i+1 : M
        dm = norm( Pcur(2*i-1:2*i) - Pcur(2*j-1:2*j)  );
        if dm < mindism_p
            mindism_p = dm;
        end
    end
end
% Minimum filtered position among UAVs 
mindism = 100000;
for i=1:M
    for j = i+1 : M
        dm = norm( (Pcur(2*i-1:2*i)+1/UavTeam.gain*Vcur(2*i-1:2*i)) - (Pcur(2*j-1:2*j)+1/UavTeam.gain*Vcur(2*j-1:2*j))  );
        if dm < mindism
            mindism = dm;
        end
    end
end

mindism_e = 100000;

    p1 = Pes(1:2)+1/UavTeam.gain*Ves(1:2);

    for j = 2 : M


    p2 = ksiO(4*j-3:4*j-2)+1/UavTeam.gain*ksiO(4*j-1:4*j);
    dm= norm( p2-p1);
            if dm < mindism_e
            mindism_e = dm;
        end
    end



% Minimum distance between UAVs and Obstacles
% mindiso = 100000;
%   sz   =  size(Obstacle);
% for i=1:M
%     for j = 1 : sz(2)
%         do = norm(Pcur(2*i-1:2*i)+1/UavTeam.gain*Vcur(2*i-1:2*i) - Obstacle(j).Center);
%         if do< mindiso
%             mindiso = do;
%         end
%     end
% end
% mindism_1 = 100000;

%     for i = 2 : M
%         dm_1 = norm( (Pcur_itself(1:2)+1/UavTeam.gain*Vcur_itself(1:2)) - (UavTeam.Uav(1).Pes_p(2*i-1:2*i)+1/UavTeam.gain*UavTeam.Uav(1).Ves_p(2*i-1:2*i))  );
%         if dm_1< mindism_1
%             mindism_1 = dm_1;
%         end
% 
%     end
%  
u = [mindism_p;mindism;mindism_e];

