function [f_out,ts,ts_k_out]=demo1_minimum_snap_simple_tube(waypts,T,n_order,regular_flag)
%     clear,clc;
% waypts:路径点。1行表示x，2行表示y
% T:总时间设置
% n_order:多项式阶数
% regular_flag:正则约束标志位。1表示加入正则条件，0表示不加入。
    % 规划管道生成线
    global r_max bw1
    v0 = [(waypts(1:2,2) - waypts(1:2,1))'/norm(waypts(1:2,2) - waypts(1:2,1)),0];
%     v0 = [1,1,0,0];
    a0 = [0,0,0,0];
    v1 = [(waypts(1:2,end) - waypts(1:2,end-1))'/norm(waypts(1:2,end) - waypts(1:2,end-1))',0];
%     v1 = [1,1,0,0];
    a1 = [0,0,0,0];

    ts = arrangeT(waypts,T);%时间分配

    % trajectory plan
    polys_x = minimum_snap_single_axis_simple(waypts(1,:),ts,n_order,v0(1),a0(1),v1(1),a1(1),2);
    polys_y = minimum_snap_single_axis_simple(waypts(2,:),ts,n_order,v0(2),a0(2),v1(2),a1(2),2);
    % 数值计算生成线
    fx=[];fx1=[];fx2=[];fy=[];fy1=[];fy2=[];fr1=[];fr2=[];ft=[];
    for i=1:size(polys_x,2)
        tt = ts(i):0.01:ts(i+1);
        xx = polys_vals(polys_x,ts,tt,0);
        xx1 =polys_vals(polys_x,ts,tt,1);
        xx2 =polys_vals(polys_x,ts,tt,2);
        yy = polys_vals(polys_y,ts,tt,0);
        yy1 = polys_vals(polys_y,ts,tt,1);
        yy2 = polys_vals(polys_y,ts,tt,2);
        fx=[fx xx];fx1=[fx1 xx1];fx2=[fx2 xx2];
        fy=[fy yy];fy1=[fy1 yy1];fy2=[fy2 yy2];
        ft=[ft tt];
    end
    plot(fx(1,100:end),fy(1,100:end),'-r');
    
    [ts_out,route_l_out,route_r_out,ts_k_out,mindis_r,mindis_l]=arrangeP1(fx,fx1,fx2,fy,fy1,fy2,ft);%重新规划半径时间段,使得相同弯曲方向的分为一段
    plot(fx(ts_k_out),fy(ts_k_out),'g*');
%
    if regular_flag == 0
        route_l_out = ones(1,length(route_l_out))*r_max;
        route_r_out = route_l_out;
    end
%     
    polys_r1 = minimum_snap_single_radius_simple(route_l_out',ts_out,n_order,v0(3),a0(3),v1(3),a1(3),1,mindis_l);
    polys_r2 = minimum_snap_single_radius_simple(route_r_out',ts_out,n_order,v0(3),a0(3),v1(3),a1(3),1,mindis_r);
  
    for k=2:size(polys_r1,2)
        tt = ft(ts_k_out(k-1):ts_k_out(k)-1);
        rr1 = polys_vals(polys_r1,ts_out,tt,0);
        fr1=[fr1 rr1];
        rr2 = polys_vals(polys_r2,ts_out,tt,0);
        fr2=[fr2 rr2];
    end
    k=k+1;
    tt = ft(ts_k_out(k-1):ts_k_out(k));
    rr1 = polys_vals(polys_r1,ts_out,tt,0);
    fr1=[fr1 rr1];
    rr2 = polys_vals(polys_r2,ts_out,tt,0);
    fr2=[fr2 rr2];
    f_out=[fx;fy;fx1;fy1;fr1;fr2];
end


function polys = minimum_snap_single_axis_simple(waypts,ts,n_order,v0,a0,ve,ae,n_obj)
% input:
% waypts:一维位置序列
% ts:时间分配序列
% n_order:多项式阶数
% v0:初始速度
% a0:初始加速度
% ve:最终速度
% ae:最终加速度
% n_obj:目标函数优化阶数
% output:
% polys:m*n矩阵，其中m表示多项式系数数量，n表示多项式分段数

p0 = waypts(1);%初始位置
pe = waypts(end);%终点位置

n_poly = length(waypts)-1;%划分多项式段数
n_coef = n_order+1;%多项式系数数量为点数+1

% compute Q 目标函数
Q_all = [];
for i=1:n_poly
    %blkdiag:分块对角矩阵
    Q_all = blkdiag(Q_all,computeQ(n_order,n_obj,ts(i),ts(i+1)));
end
b_all = zeros(size(Q_all,1),1);

Aeq = zeros(4*n_poly+2,n_coef*n_poly);
beq = zeros(4*n_poly+2,1);

% start/terminal pva constraints  (6 equations)
% 初始端、末端的时间、加速度、速度、位置的约束
Aeq(1:3,1:n_coef) = [calc_tvec(ts(1),n_order,0);
                     calc_tvec(ts(1),n_order,1);
                     calc_tvec(ts(1),n_order,2)];
Aeq(4:6,n_coef*(n_poly-1)+1:n_coef*n_poly) = ...
                    [calc_tvec(ts(end),n_order,0);
                     calc_tvec(ts(end),n_order,1);
                     calc_tvec(ts(end),n_order,2)];
beq(1:6,1) = [p0,v0,a0,pe,ve,ae]';

% mid p constraints    (n_ploy-1 equations)
neq = 6;
for i=1:n_poly-1
    neq=neq+1;
    Aeq(neq,n_coef*i+1:n_coef*(i+1)) = calc_tvec(ts(i+1),n_order,0);
    beq(neq) = waypts(i+1);
end

% continuous constraints  ((n_poly-1)*3 equations)
for i=1:n_poly-1
    tvec_p = calc_tvec(ts(i+1),n_order,0);
    tvec_v = calc_tvec(ts(i+1),n_order,1);
    tvec_a = calc_tvec(ts(i+1),n_order,2);
    neq=neq+1;
    Aeq(neq,n_coef*(i-1)+1:n_coef*(i+1))=[tvec_p,-tvec_p];
    neq=neq+1;
    Aeq(neq,n_coef*(i-1)+1:n_coef*(i+1))=[tvec_v,-tvec_v];
    neq=neq+1;
    Aeq(neq,n_coef*(i-1)+1:n_coef*(i+1))=[tvec_a,-tvec_a];
end

% 没有不等式约束
Aieq = [];
bieq = [];
% i=1;
% for i=1:n_poly
%     temp=[zeros(1,(i-1)*n_coef) 0 1 2*(ts(i)+ts(i+1)*0.8) 3*(ts(i)+ts(i+1)*0.8)^2 ...
%          4*(ts(i)+ts(i+1)*0.8)^3 5*(ts(i)+ts(i+1)*0.8)^4 6*(ts(i)+ts(i+1)*0.8)^5 ... 
%          7*(ts(i)+ts(i+1)*0.8)^6 8*(ts(i)+ts(i+1)*0.8)^7 zeros(1,(n_poly-i)*n_coef)];
%     Aieq=[Aieq;temp];
%     bieq=[bieq;4];
% end

p = quadprog(Q_all,b_all,Aieq,bieq,Aeq,beq);

polys = reshape(p,n_coef,n_poly);

end

function polys = minimum_snap_single_radius_simple(waypts,ts,n_order,v0,a0,ve,ae,n_obj,mindis_k)
% input:
% waypts:一维位置序列
% ts:时间分配序列
% n_order:多项式阶数
% v0:初始速度
% a0:初始加速度
% ve:最终速度
% ae:最终加速度
% n_obj:目标函数优化阶数
% output:
% polys:m*n矩阵，其中m表示多项式系数数量，n表示多项式分段数

p0 = waypts(1);%初始位置
pe = waypts(end);%终点位置

n_poly = length(waypts)-1;%划分多项式段数
n_coef = n_order+1;%多项式系数数量为点数+1


% compute Q 目标函数
Q_all = [];
for i=1:n_poly
    %blkdiag:分块对角矩阵
    Q_all = blkdiag(Q_all,computeQ(n_order,1,ts(i),ts(i+1)));
end
b_all = zeros(size(Q_all,1),1);


Q_all1 = [];
for i=1:n_poly
    %blkdiag:分块对角矩阵
    Q_all1 = blkdiag(Q_all1,computeQ(n_order,0,ts(i),ts(i+1)));
end


Aeq = zeros(3*n_poly+1,n_coef*n_poly);
beq = zeros(3*n_poly+1,1);

% start/terminal pva constraints  (4 equations)
Aeq(1:2,1:n_coef) = [calc_tvec(ts(1),n_order,0);
    calc_tvec(ts(1),n_order,1)];
Aeq(3:4,n_coef*(n_poly-1)+1:n_coef*n_poly) = ...
                    [calc_tvec(ts(end),n_order,0);
                    calc_tvec(ts(end),n_order,1)];
beq(1:4,1) = [1/p0,v0,1/pe,ve]';

% mid p constraints    (n_ploy-1 equations)
neq = 4;
% beq(1:neq,1)=0;
% for i=1:n_poly-1
%     neq=neq+1;
%     Aeq(neq,n_coef*i+1:n_coef*(i+1)) = calc_tvec(ts(i+1)-0.1,n_order,0);
%     beq(neq) = 1/waypts(i+1);
%     neq=neq+1;
%     Aeq(neq,n_coef*i+1:n_coef*(i+1)) = calc_tvec(ts(i)+0.1,n_order,0);
%     beq(neq) = 1/waypts(i);
% end

% continuous constraints  ((n_poly-1)*3 equations)
for i=1:n_poly-1
    tvec_p = calc_tvec(ts(i+1),n_order,0);
    tvec_v = calc_tvec(ts(i+1),n_order,1);
    neq=neq+1;
    Aeq(neq,n_coef*(i-1)+1:n_coef*(i+1))=[tvec_p,-tvec_p];
    beq(neq)=0;
    neq=neq+1;
    Aeq(neq,n_coef*(i-1)+1:n_coef*(i+1))=[tvec_v,-tvec_v];
    beq(neq)=0;
%     Aeq(neq,n_coef*(i-1)+1:n_coef*i)=tvec_v;
end

% 不等式约束
Aieq=[];
bieq=[];

neq=0;
% neq = neq + 1;
% Aieq1(neq,1:n_coef) = calc_tvec(ts(1),n_order,0);
% bieq1(neq,1) = 1/waypts(i);
for i=1:n_poly
    neq=neq+1;
    Aieq1(neq,n_coef*(i-1)+1:n_coef*i) = calc_tvec(ts(i+1),n_order,0);
    bieq1(neq,1) = 1/waypts(i+1);
    if mindis_k(i,1)~=0
        neq=neq+1;
        Aieq1(neq,n_coef*(i-1)+1:n_coef*i) = calc_tvec(mindis_k(i,3),n_order,0);
        bieq1(neq,1) = 1/mindis_k(i,2);
    end
end

Aieq=[-Aieq1];
bieq=[-bieq1];
% Aieq=[Aieq;-Aieq1];
% bieq=[bieq;-zeros(length(bieq),1)];

w1=1;
w2=0.008;
w1=w1/(w1+w2);
w2=w2/(w1+w2);

p = quadprog(w1*Q_all+w2*Q_all1,b_all,Aieq,bieq,Aeq,beq);

polys = reshape(p,n_coef,n_poly);

end