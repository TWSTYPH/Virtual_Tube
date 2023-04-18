clc
clear
global rs ra rm rs_r rd ro_s
load('m222.mat')
M=2;
rm =0.2;
ro_s = 0.6;
Ts=0.01;
time_end=49;
ro = 0.8;
%Upper bound of noise & Rate of packet loss
bp = 0.2;
bv = 0.2;
bl = 0.2;
loss_rate=0.3;
taod=2;
L=5;
vm=0.1;
rv=0.04;
rji=loss_rate*Ts/(1-loss_rate)*vm+bp+1/L*bv+vm*taod+bl;
% rs=sqrt(rm^2+rv^2)+rji/2;
rs_r=sqrt(rm^2+rv^2);
 rs=sqrt((rm+ro_s)^2+rv^2)+rji-ro_s;
    figure(1);
for j=4800:10:time_end/Ts+1
    t=j
hold off
    for k = 1: M
    o1 = [data{3}.Values.Data(j,6*(k-1)+1) data{3}.Values.Data(j,6*(k-1)+2)]';
    o2 = [data{3}.Values.Data(j,6*(k-1)+1)+data{3}.Values.Data(j,6*(k-1)+4)/L data{3}.Values.Data(j,6*(k-1)+2)+data{3}.Values.Data(j,6*(k-1)+5)/L]';
    mydrawcolorball(o1,o2,k);  
legend('rs','rm')
axis([-3 3 -3 3])
ylabel('True Positions')
grid on
if k==1
    p1 = [data{1}.Values.Data(j,4*k-3) data{1}.Values.Data(j,4*k-2)]';
    p2 = [data{1}.Values.Data(j,4*k-3)+data{1}.Values.Data(j,4*k-1)/L data{1}.Values.Data(j,4*k-2)+data{1}.Values.Data(j,4*k)/L]';
else
    p3 = [data{2}.Values.Data(j,4*k-3) data{2}.Values.Data(j,4*k-2)]';
    p4 = [data{2}.Values.Data(j,4*k-3)+data{2}.Values.Data(j,4*k-1)/L data{2}.Values.Data(j,4*k-2)+data{2}.Values.Data(j,4*k)/L]';
end
    end

mycircle_dotted(p2,rs);
    mycircle_dotted(p4,ro_s);
    axis([-3 3 -3 3])
    legend('rs','rm','ro','View of UAV');
hold off
grid on

    pause(5);
end
out = 0;
% load('M2SAFETY.mat')
%     o1 = data{1}{1}.Values.Data(2:end-100,1:2);
%     o2 = data{1}{2}.Values.Data(101:end-1,1:2);
%     o3 = data{1}{2}.Values.Data(102:end,1:2);
% 
%     o4=0.3*o2+0.7*o1;
%     o5=o4-o3;
%     o6=sqrt(o5(:,1).^2+o5(:,2).^2);
% 
% find(o6==max(o6))
% find(o6==min(o6))
% figure(2)
% subplot(2,1,1)
% edges=[-3:0.2:3];
% [f1,x_1] = ksdensity(o5(:,1));
% plot(x_1,f1*1600,'r','LineWidth',2)
% xlabel('x-axis direction error')
% axis([-3 3 0 1000])
% hold on 
% histogram(o5(:,1),edges)
% subplot(2,1,2)
% [f2,x_2] = ksdensity(o5(:,2));
% plot(x_2,f2*1600,'r','LineWidth',2)
% xlabel('y-axis direction error')
% axis([-3 3 0 1000])
% hold on
% histogram(o5(:,2),edges)