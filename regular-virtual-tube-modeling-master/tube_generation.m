% close all;
% imshow(~bw1)
% figure(2),
hold on;

[col,~]=size(route1);


global r_max 
r_max=30;
route1(1:col,3)=r_max;
plot(route1(:,1),route1(:,2),'o');axis equal;

n_order=6;
total_time=100;
[f,ts,ts_k]=demo1_minimum_snap_simple_tube(route1',total_time,n_order,1);
% plot(f(1,:),f(2,:),'-r');

tangent=[f(3,:);
    f(4,:)];
rot=[0 -1;1 0];
normal=rot*tangent;
normal=normal./sum(normal.^2,1).^0.5;
% 固定半径
fo1=f(1:2,:)-r_max.*normal;
plot(fo1(1,20:end),fo1(2,20:end),'-b');
fo2=f(1:2,:)+r_max.*normal;
plot(fo2(1,20:end),fo2(2,20:end),'-b');
fo1_cons = fo1;
fo2_cons = fo2;
% 变半径
fo1=f(1:2,:)-1./f(5,:).*normal;
plot(fo1(1,20:end),fo1(2,20:end),'-k','linewidth',2);
fo2=f(1:2,:)+1./f(6,:).*normal;
plot(fo2(1,20:end),fo2(2,20:end),'-k','linewidth',2);
axis equal;
fo1_reg = fo1;
fo2_reg = fo2;

% non-regular tube generation
[f,ts,ts_k]=demo1_minimum_snap_simple_tube(route1',total_time,n_order,0);
fo1=f(1:2,:)-1./f(5,:).*normal;
plot(fo1(1,20:end),fo1(2,20:end),'-g','linewidth',2);
fo2=f(1:2,:)+1./f(6,:).*normal;
plot(fo2(1,20:end),fo2(2,20:end),'-g','linewidth',2);
fo1_nonreg = fo1;
fo2_nonreg = fo2;

% legend('o','*','generating curve',...
%     'offset curve 1','offset curve 2',...
%     'virtual curve 1','virtual curve 2');
% plot(fo1(1,ts_k),fo1(2,ts_k),'or');
% plot(fo2(1,ts_k),fo2(2,ts_k),'or');




