
global rs ra rm rs_r rd
load('M2SAFETY.mat')
M=2;
rm =5;
Ts=0.01;
time_end=55;
ro = 80;
%Upper bound of noise & Rate of packet loss
bp = 5;
bv = 5;
bl = 6;
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



% for j=1:20:time_end/Ts+1
for j=3400:100:time_end/Ts+1
    t=j
hold off
    for k = 1: M
 
        subplot(3,1,1)

    o1 = [data{1}{3}.Values.Data(j,2*k-1) data{1}{3}.Values.Data(j,2*k)]';
    o2 = [data{1}{3}.Values.Data(j,2*k-1)+data{1}{3}.Values.Data(j,2*k+3)/L data{1}{3}.Values.Data(j,2*k)+data{1}{3}.Values.Data(j,2*k+4)/L]';
    mydrawcolorball(o1,o2,k);  
% legend('rd','ra','rs','rm')
legend('rddddddddddddddddddddddddddddd','raaaaaaaaaaaaaaaaaaaaaaaaaaaaa')
axis([-90 90 -60 60])
ylabel('True Positions')
grid on
if k ==2
    hold off
end
subplot(3,1,2)


if k==1
    o1 = [data{1}{1}.Values.Data(j,4*k-3) data{1}{1}.Values.Data(j,4*k-2)]';
    o2 = [data{1}{1}.Values.Data(j,4*k-3)+data{1}{1}.Values.Data(j,4*k-1)/L data{1}{1}.Values.Data(j,4*k-2)+data{1}{1}.Values.Data(j,4*k)/L]';
else
    o1 = [data{1}{2}.Values.Data(j,4*k-3) data{1}{2}.Values.Data(j,4*k-2)]';
    o2 = [data{1}{2}.Values.Data(j,4*k-3)+data{1}{2}.Values.Data(j,4*k-1)/L data{1}{2}.Values.Data(j,4*k-2)+data{1}{2}.Values.Data(j,4*k)/L]';
end


    mydrawcolorball(o1,o2,k);  
            mycircle_dotted(o2,rs);
%     mydrawcolorball(o3,o4,k);  


axis([-90 90 -60 60])
ylabel('View of UAV1')
grid on
if k ==2
    hold off
end
subplot(3,1,3)
if k==2

    o1 = [data{1}{1}.Values.Data(j,4*k-3) data{1}{1}.Values.Data(j,4*k-2)]';
    o2 = [data{1}{1}.Values.Data(j,4*k-3)+data{1}{1}.Values.Data(j,4*k-1)/L data{1}{1}.Values.Data(j,4*k-2)+data{1}{1}.Values.Data(j,4*k)/L]';
else
    o1 = [data{1}{2}.Values.Data(j,4*k-3) data{1}{2}.Values.Data(j,4*k-2)]';
    o2 = [data{1}{2}.Values.Data(j,4*k-3)+data{1}{2}.Values.Data(j,4*k-1)/L data{1}{2}.Values.Data(j,4*k-2)+data{1}{2}.Values.Data(j,4*k)/L]';
end
    mydrawcolorball(o1,o2,k);  
%         mydrawcolorball(o3,o4,k);
        mycircle_dotted(o2,rs);
ylabel('View of UAV2')
axis([-90 90 -60 60])
grid on
if k ==2
    hold off
end

    end
    pause(2);

end
out = 0;
load('M2SAFETY.mat')
    o1 = data{1}{1}.Values.Data(2:end-100,1:2);
    o2 = data{1}{2}.Values.Data(101:end-1,1:2);
    o3 = data{1}{2}.Values.Data(102:end,1:2);

    o4=0.3*o2+0.7*o1;
    o5=o4-o3;
    o6=sqrt(o5(:,1).^2+o5(:,2).^2);

find(o6==max(o6))
find(o6==min(o6))
figure(2)
subplot(2,1,1)
edges=[-3:0.2:3];
[f1,x_1] = ksdensity(o5(:,1));
plot(x_1,f1*1600,'r','LineWidth',2)
xlabel('x-axis direction error')
axis([-3 3 0 1000])
hold on 
histogram(o5(:,1),edges)
subplot(2,1,2)
[f2,x_2] = ksdensity(o5(:,2));
plot(x_2,f2*1600,'r','LineWidth',2)
xlabel('y-axis direction error')
axis([-3 3 0 1000])
hold on
histogram(o5(:,2),edges)