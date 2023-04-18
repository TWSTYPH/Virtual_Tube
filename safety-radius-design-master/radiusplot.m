function out=radiusplot(o1,o2,k)
global rm rs ra rd rs_r ro_s

%         mycicle(o1,rm)
% 
%         mycircle_b(o2,rs)
% 
%         mycircle_g(o2,ra)

%         mycircle_y(o1,rd)

%  mycircle_g(o2,ra)
if k==1
  mycircle_c(o2,rs)
          hold on
      mycicle(o1,rm)
else
     mycircle_g(o2,ro_s)
end