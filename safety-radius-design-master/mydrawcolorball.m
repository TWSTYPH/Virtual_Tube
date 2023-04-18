function out=mydrawcolorball(o1,o2,k)
global rs ra rd rs_r rm


        radiusplot(o1,o2,k)
        hold on
%         legend('rd','ra','ro')
%         mycircle_g(o2,ra)

%         hold on

%     if (k==1) 
%         plot(o1(1),o1(2),'.','MarkerSize',15,'MarkerEdgeColor','y','MarkerFaceColor', 'y');
%         radiusplot(o1,o2,k)
%         hold on
% 
%     elseif (k==2)
%        plot(o1(1),o1(2),'.','MarkerSize',15,'MarkerEdgeColor','m','MarkerFaceColor', 'm');
%        radiusplot(o1,o2,k)
% %         hold on
%     elseif (k==3)
%        plot(o1(1),o1(2),'.','MarkerSize',15,'MarkerEdgeColor','c','MarkerFaceColor', 'c');
%        radiusplot(o1,o2,k)
% %         hold on
%     elseif (k==4)
%         plot(o1(1),o1(2),'.','MarkerSize',15,'MarkerEdgeColor','r','MarkerFaceColor','r');
%         radiusplot(o1,o2,k)
% %         hold on
%     elseif (k==5)
%         plot(o1(1),o1(2),'.','MarkerSize',15,'MarkerEdgeColor','g','MarkerFaceColor', 'g');
%         radiusplot(o1,o2,k)
% %         hold on       
%     elseif k==6
%         plot(o1(1),o1(2),'.','MarkerSize',15,'MarkerEdgeColor','b','MarkerFaceColor', 'b');
%         radiusplot(o1,o2,k)
% %         hold on  
%     else
%         plot(o1(1),o1(2),'.','MarkerSize',15,'MarkerEdgeColor','k','MarkerFaceColor', 'k');
%         radiusplot(o1,o2,k)
% %         hold on        
%     end