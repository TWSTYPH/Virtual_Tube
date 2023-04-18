clc;
clear all;
global Highway Obstacle
global UavTeam
global gcount gfigure gcount2
global rm rs ra rv rd rji ro_s
global bp bv bl taod Ts vm rs_r vbp vbv
global loss_rate


% number = 4; %%%%%%%%%%%%%%%%% the number of UAV observation
gcount = 0;
gfigure = 0;
gcount2 = 0;
rm =5;

Ts=0.01;
time_end=65;
ro = 80;
ro_s = 10;
%Upper bound of noise & Rate of packet loss
bp = 2;
bv = 5;
bl = 1;
loss_rate=0.1;
taod=1;
vbp=8;
vbv=10;
% % 
% bp = 3;
% bv = 10;
% bl = 2;
% loss_rate=0.2;
% taod=2;
% vbp=12;
% vbv=10;
% 
% bp = 0;
% bv = 0;
% bl = 0;
% loss_rate=0;
% taod=0;
% vbp=0;
% vbv=0;

% Highway(1).ph1  = [500  100]'; 
% Highway(1).ph2  = [1000 100]';
% Highway(1).rh   =  50;
% Highway(2).ph1  = [1000 700]'; 
% Highway(2).ph2  = [500  700]';
% Highway(2).rh   =  50;
% Initialize Obstacle
% Obstacle(1).Center  = [-400 0]';
% Obstacle(1).r  = ro;
% Obstacle(1).Velocity = 2;
% Obstacle(1).angle = 0;
% Obstacle(1).gain = [Obstacle(1).Velocity * Ts * cos(Obstacle(1).angle) Obstacle(1).Velocity * Ts * sin(Obstacle(1).angle)]';

% Initialize UavTeam
M = 4; 
UavTeam = UAVInitialization(M,rm);

L=UavTeam.gain;
rji=loss_rate*Ts/(1-loss_rate)*5+bp+1/L*bv+5*taod+bl;

% rs=sqrt(rm^2+rv^2)+rji/2;
 rs=sqrt((rm+ro_s)^2+rv^2)+rji-ro_s;
rs_r=sqrt(rm^2+rv^2);
ra=2*rs;
rd=ra+rs+2*rv;

% Ep1=5*rand*cos(2*pi*rand);
% Ep2=5*rand*cos(2*pi*rand);
% Ev1=5*rand*cos(2*pi*rand);
% Ev2=5*rand*cos(2*pi*rand);
for k=1:M
UavTeam.Uav(k).rs = rs;
UavTeam.Uav(k).ra = ra;
end
% E=loss_rate*Ts/(1-loss_rate)*vm+4*(bp+1/L*bv)+bl;
% Draw 2D map
figure(1);
% MyMap(UavTeam,Obstacle,Highway);

'start'
sim('platform_B3.slx')
'over'

figure(2)
subplot(2,1,1)
plot(mindis(:,1),mindis(:,2),'-','LineWidth',2); hold on;
ksm = find(mindis(:,2)==min(mindis(:,2)));
text(mindis(ksm(1),1),mindis(ksm(1),2),['\downarrow' num2str(mindis(ksm(1),2))],'HorizontalAlignment','left')
plot(mindis(:,1),( rm+ro_s)*ones(size(mindis(:,1))),'r-.','LineWidth',2);
text(2,rm+ro_s+5,['\downarrow rm+ro'],'HorizontalAlignment','left')
legend('Between UAV and obstacle')
xlabel('t(sec)')
ylabel('Position error(m)')
axis([0 time_end  0 90])
subplot(2,1,2)
plot(mindis(:,1),mindis(:,4),'-','LineWidth',2); hold on;
ksm = find(mindis(:,4)==min(mindis(:,4)));
text(mindis(ksm(1),1),mindis(ksm(1),4)-0.2,['\uparrow' num2str(mindis(ksm(1),4))],'HorizontalAlignment','left')
plot(mindis(:,1),( rs+ro_s)*ones(size(mindis(:,1))),'r-.','LineWidth',2);
text(2,rs+ro_s+5,['\downarrow rm+ro'],'HorizontalAlignment','left')
legend('Between UAV and obstacle')
xlabel('t(sec)')
ylabel('Position error(m)')
axis([0 time_end  0 90])
