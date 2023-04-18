function out = mycircle_y(o,r)
 alpha = 0:pi/20:2*pi;    
 x = o(1) +  r*cos(alpha); 
 y = o(2) +  r*sin(alpha); 
  plot(x,y,'y-','LineWidth',1) 
 h=fill(x,y,'y-');
 set(h,'edgealpha',1,'facealpha',0.3) 