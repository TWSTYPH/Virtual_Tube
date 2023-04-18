close all;clear all;
%% ������ɵ�ͼ
global obstacle bw1
map_x=100;
map_y=100;
obstacle.num=70;
obstacle.rmax=6;
obstacle.obs=draw_obstacle(map_x,map_y,obstacle.num,obstacle.rmax);
%% ץȡͼ�������߼�����
f=getframe(gcf);
img=f.cdata;
bw1=~im2bw(img);
%% �ָ�ͼƬ
% load('20220111_data_1.mat');
bili=20;
bw1=double(bw1);
[row,col]=size(bw1);
itv=floor(min(row,col)/bili);
count_r=0;count_c=0;
for k=1:itv:row-itv+1
    count_r=count_r+1;
   for m=1:itv:col-itv+1
       count_c=count_c+1;
      if sum(sum(bw1(k:k+itv-1,m:m+itv-1))) >itv*itv/4
          bw2(count_r,count_c)=1;
      else
          bw2(count_r,count_c)=0;    
      end
   end
   count_c=0;
end
% figure,imshow(bw2);
[row2,col2]=size(bw2);
for k=1:row2
   for m=1:col2
      if bw2(k,m)==1
         bw2(k,m)=-inf;
      else
          bw2(k,m)=inf;
      end
   end
end
hold off;
imshow(~bw1);
hold on;
%% ѡȡ�����յ�
% [start_pos(1,1),start_pos(1,2)]=ginput(1);
start_pos = [70 192];
text(start_pos(1,1)+0.1,start_pos(1,2),'start point');
% [end_pos(1,1),end_pos(1,2)]=ginput(1);
end_pos = [500 192];
text(end_pos(1,1)+0.1,end_pos(1,2),'end point');
start_pos=start_pos/itv;
end_pos=end_pos/itv;

%% ·������
[route]=AStar(bw2',ceil(start_pos),ceil(end_pos));
route1=(route-0.5)*itv;
figure(1),
plot(route1(1:end,1),route1(1:end,2),'--');
plot(route1(1:end,1),route1(1:end,2),'or');
% figure,image(bw2,'CDataMapping','scaled');hold on;
% plot(route(:,1),route(:,2),'.r');
%% ���ɹܵ�
tube_generation
%% ��������
filename = datestr(now,30);
save(['D:\nonlinear system\virtual tube for git\data\',filename,'.mat']);
savefig(['D:\nonlinear system\virtual tube for git\data\',filename,'.fig']);
