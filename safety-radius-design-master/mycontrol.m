function u = mycontrol(i)
global Obstacle
global UavTeam E bp bv ro_s

L=UavTeam.gain;
gamma =  1.012;
Pcur  =  UavTeam.Uav(i).Pes;
Vcur  =  UavTeam.Uav(i).Ves;
Pdes  =  UavTeam.Uav(i).Waypoint(:,UavTeam.Uav(i).CurrentTaskNum);
   rs = UavTeam.Uav(i).rs;
   ra = UavTeam.Uav(i).ra;     
   vm = UavTeam.Uav(i).vmax;
   

% Velocity to waypoint
    k1 = 1;
ksi_w  = Pcur + 1/UavTeam.gain*Vcur - Pdes;
    Vw = - mysat(k1*ksi_w,vm);

% Velocity away obstacles
    sz  =  size(Obstacle);
    Vo  = [0;0];
  for j = 1:sz(2)
     k2 = 1; e = 0.000001; 
 ksioij = Pcur + 1/UavTeam.gain*Vcur - Obstacle(j).Center;
     ro = Obstacle(j).r;     
   temp = (1+e)*norm(ksioij) - (rs+ro)*mys(norm(ksioij)/(rs+ro),e);
    aij = k2*dmysigma(norm(ksioij),rs+ro,ra+ro)/temp ...
        - k2*mysigma(norm(ksioij),rs+ro,ra+ro)*((1+e)-dmys(norm(ksioij)/(rs+ro),e))/(temp^2);
     Vo = Vo - aij*(ksioij/norm(ksioij));
  end
 
% %   % Velocity away other multicopters
    Vm = [0;0];

    for j = 1:UavTeam.AvailableNumMax
        if i~=j 
if (i ==1 || j==1)
     k3 = 1; e = 0.000001;
 ksimil = (Pcur - UavTeam.Uav(j).PesO) + 1/UavTeam.gain * (Vcur - UavTeam.Uav(j).VesO);
   temp = (1+e)*norm(ksimil) - (gamma*rs+ro_s)*mys(norm(ksimil)/(gamma*rs+ro_s),e);
    bil = k3*dmysigma(norm(ksimil),gamma*rs+ro_s,ra+rs)/temp ...
        - k3*mysigma(norm(ksimil),gamma*rs+ro_s,ra+rs)*((1+e)-dmys(norm(ksimil)/(gamma*rs+ro_s),e))/(temp^2);
     Vm = Vm - bil*(ksimil/norm(ksimil));
else
      k3 = 1; e = 0.000001;
 ksimil = (Pcur - UavTeam.Uav(j).CurrentPos) + 1/UavTeam.gain * (Vcur - UavTeam.Uav(j).Velocity);
   temp = (1+e)*norm(ksimil) - ((1+gamma)*ro_s)*mys(norm(ksimil)/((1+gamma)*ro_s),e);
    bil = k3*dmysigma(norm(ksimil),(1+gamma)*ro_s,ra+rs)/temp ...
        - k3*mysigma(norm(ksimil),(1+gamma)*ro_s,ra+rs)*((1+e)-dmys(norm(ksimil)/((1+gamma)*ro_s),e))/(temp^2);
     Vm = Vm - bil*(ksimil/norm(ksimil));       
end
        end
    end

   % Sum of all velocities
    u = mysat(Vw+Vo+Vm,vm);