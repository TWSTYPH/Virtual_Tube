function out = mycircle_c(o,r)
 alpha = 0:pi/20:2*pi;    
 x = o(1) +  r*cos(alpha); 
 y = o(2) +  r*sin(alpha); 
 

 h=fill(x,y,'c-');
 set(h,'edgealpha',1,'facealpha',0.3) 