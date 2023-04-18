function out = mycircle_g(o,r)
 alpha = 0:pi/20:2*pi;    
 x = o(1) +  r*cos(alpha); 
 y = o(2) +  r*sin(alpha); 

%   plot(x,y,'g-','LineWidth',1) 
 h=fill(x,y,'g-');
  set(h,'edgealpha',1,'facealpha',0.6) 