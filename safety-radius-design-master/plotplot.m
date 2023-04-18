function out = plot_M4
global rs ra

rm = 10;
l  = 5;
vmax = 15;
ro = 0;
rs=0.2;
ra=1.5*rs;
rd=ra+rs+2*vmax;
M = 4;


    figure(1);
    
 a1=[0.42 0.93 -0.12 -0.08  0.5 0.15 0.87 -0.15]';
 a2=[-0.12 0.4  0.75 -0.92 0.5 0.4  0.92 -0.1]';
 a3=[-0.78 -0.45  1.48 -1.52 1.15 1.12 0.35 0.4]';
 a4=[-1.45 -1.47  1.495 -1.52 1.44 1.5 -1.52 1.5]';
 b=[-1.5 -1.5 1.5 -1.5 1.5 1.5 -1.5 1.5]';
 
subplot(2,2,1)
for k = 1: M

    plot(b(2*k-1), b(2*k),'rp','MarkerSize',10)
    hold on

    end



    for k = 1: M
    o1 = [a1(2*k-1)  a1(2*k)]';
radiusplot1(o1,k)
    hold on
    end

    axis([-2 2 -2 2]) 
grid on

subplot(2,2,2)
for k = 1: M

    plot(b(2*k-1), b(2*k),'rp','MarkerSize',10)
    hold on

    end



    for k = 1: M
    o1 = [a2(2*k-1)  a2(2*k)]';
radiusplot1(o1,k)
    hold on
    end

    axis([-2 2 -2 2]) 
grid on

subplot(2,2,3)
for k = 1: M

    plot(b(2*k-1), b(2*k),'rp','MarkerSize',10)
    hold on

    end



    for k = 1: M
    o1 = [a3(2*k-1)  a3(2*k)]';
radiusplot1(o1,k)
    hold on
    end

    axis([-2 2 -2 2]) 
grid on

subplot(2,2,4)
for k = 1: M

    plot(b(2*k-1), b(2*k),'rp','MarkerSize',10)
    hold on

    end



    for k = 1: M
    o1 = [a4(2*k-1)  a4(2*k)]';
    radiusplot1(o1,k)
    hold on
    end

    axis([-2 2 -2 2]) 
grid on


end


