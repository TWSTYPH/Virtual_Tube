function out = mycircle_dotted(o,r)
 alpha = 0:pi/20:2*pi;    
 x = o(1) +  r*cos(alpha); 
 y = o(2) +  r*sin(alpha); 
h1= plot(x,y,'r--','LineWidth',1); 
%          legend(h1,'View of UAV')
% hold on