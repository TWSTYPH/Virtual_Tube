function [sys,x0,str,ts] = AttitudeDynamics(t,x,u,flag)
switch flag,
case 0,
    [sys,x0,str,ts]=mdlInitializeSizes;
case 1,
    sys=mdlDerivatives(t,x,u);
case 3,
    sys=mdlOutputs(t,x,u);
case {2,4,9}
    sys=[];
otherwise
    error(['Unhandled flag = ',num2str(flag)]);
end
function [sys,x0,str,ts]=mdlInitializeSizes
global UavTeam
% Initialize multicopter positions 
  Pint = [];
for  k = 1: UavTeam.AvailableNumMax
  Pint = [Pint; UavTeam.Uav(k).HomePos];
end
for  k = 1: UavTeam.AvailableNumMax
  Pint = [Pint; UavTeam.Uav(k).Velocity];
end

sizes = simsizes;
sizes.NumContStates  = 4*UavTeam.AvailableNumMax;
sizes.NumDiscStates  = 0;
sizes.NumOutputs     = 4*UavTeam.AvailableNumMax;
sizes.NumInputs      = 2*UavTeam.AvailableNumMax;
sizes.DirFeedthrough = 0;
sizes.NumSampleTimes = 1;
sys = simsizes(sizes);
x0  = Pint;
str = [];
ts  = [0 0];

function sys = mdlDerivatives(t,x,u)
% dot(p) = v
% dot(v) = -UavTeam.gain*(v-vc)
% x: position
% v: velocity
% u = vc: velocity command
global UavTeam
             M = UavTeam.AvailableNumMax;
    sys(1:2*M) = x(2*M+1:4*M);
sys(2*M+1:4*M) = -UavTeam.gain*(x(2*M+1:4*M)-u);


function sys=mdlOutputs(t,x,u) 
sys = x;