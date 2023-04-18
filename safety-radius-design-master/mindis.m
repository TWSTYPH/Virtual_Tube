
M=41;
l=5;

mindis_m=[];
load('M41.mat')

for a=1:23101
    ksi_all=[];
t=a
    for k = 1: M
    ksi = [data{1}{1}.Values.Data(a,2*k-1)+data{1}{1}.Values.Data(a,82+2*k-1)/l data{1}{1}.Values.Data(a,2*k)+data{1}{1}.Values.Data(a,82+2*k)/l]';
    ksi_all=[ksi_all;ksi];
    end
    
                min_dis=100000;
for i =1:M
    for j=i+1:M

        dm = norm( ksi_all(2*i-1:2*i) - ksi_all(2*j-1:2*j));
        if dm < min_dis
            min_dis = dm;
        end
    end
end
mindis_m=[mindis_m;min_dis];
end

rs=15;
time=0:0.01:231;
time=time';
plot (time,mindis_m) 
hold on
ksh = find(mindis_m==min(mindis_m));

text(time(ksh),mindis_m(ksh),['\leftarrow' num2str(mindis_m(ksh))],'HorizontalAlignment','left')
plot(time,2*rs*ones(size(time)),'r-.');
xlabel('t(sec)')
ylabel('minimum distance(m)')
legend('Between two multicopters')
axis([0 231  0 100])
hold off

save('mindis','mindis_m')


