function out = plot_M2_SAFETYRADIUS
global rs ra rs_r rd rm
load('M2_SAFETYRADIUS.mat')
M=2;
rm =5;
Ts=0.01;
time_end=50;
ro = 80;
%Upper bound of noise & Rate of packet loss
bp = 5;
bv = 5;
bl = 1;
loss_rate=0.3;
taod=1;
L=5;
vm=5;
rv=1;
rji=loss_rate*Ts/(1-loss_rate)*vm+bp+1/L*bv+vm*taod+bl;

rs=sqrt(rm^2+rv^2)+rji/2;
rs_r=sqrt(rm^2+rv^2);
ra=1.5*rs;
rd=ra+rs+2*rv;


    figure(1);



for j=1:10:time_end/Ts+1
    hold off
    for k = 1: M
    o1 = [data{1}{3}.Values.Data(j,2*k-1) data{1}{3}.Values.Data(j,2*k)]';
    o2 = [data{1}{3}.Values.Data(j,2*k-1)+data{1}{3}.Values.Data(j,2*k+3)/L data{1}{3}.Values.Data(j,2*k)+data{1}{3}.Values.Data(j,2*k+4)/L]';
    mydrawcolorball(o1,o2,k);  
    end
axis([-80 80 -60 60])
grid on
pause(0.1);
end

% for j=1:20:time_end/Ts+1
%     hold off
%     for k = 1: M
%         if k ==1
%     o1 = [data{1}{1}.Values.Data(j,4*k-3) data{1}{1}.Values.Data(j,4*k-2)]';
%     o2 = [data{1}{1}.Values.Data(j,4*k-3)+data{1}{1}.Values.Data(j,4*k-1)/L data{1}{1}.Values.Data(j,4*k-2)+data{1}{1}.Values.Data(j,4*k)/L]';
%         else
%     o1 = [data{1}{2}.Values.Data(j,4*k-3) data{1}{2}.Values.Data(j,4*k-2)]';
%     o2 = [data{1}{2}.Values.Data(j,4*k-3)+data{1}{2}.Values.Data(j,4*k-1)/L data{1}{2}.Values.Data(j,4*k-2)+data{1}{2}.Values.Data(j,4*k)/L]';
% 
%         end
%     mydrawcolorball(o1,o2,k);  
%         mycircle_dotted(o2,rs);
%     end
% axis([-80 80 -60 60])
% grid on
% pause(0.05);
% end
% 
% for j=1:20:time_end/Ts+1
%     hold off
%     for k = 1: M
%         if k ==2
%     o1 = [data{1}{1}.Values.Data(j,4*k-3) data{1}{1}.Values.Data(j,4*k-2)]';
%     o2 = [data{1}{1}.Values.Data(j,4*k-3)+data{1}{1}.Values.Data(j,4*k-1)/L data{1}{1}.Values.Data(j,4*k-2)+data{1}{1}.Values.Data(j,4*k)/L]';
%         else
%     o1 = [data{1}{2}.Values.Data(j,4*k-3) data{1}{2}.Values.Data(j,4*k-2)]';
%     o2 = [data{1}{2}.Values.Data(j,4*k-3)+data{1}{2}.Values.Data(j,4*k-1)/L data{1}{2}.Values.Data(j,4*k-2)+data{1}{2}.Values.Data(j,4*k)/L]';
% 
%         end
%     mydrawcolorball(o1,o2,k);  
%         mycircle_dotted(o2,rs);
%     end
% axis([-80 80 -60 60])
% grid on
% pause(0.05);
% end
out = 0;