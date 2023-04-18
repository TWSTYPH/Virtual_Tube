function [p,V] = CircleCenter(p1, p2, p3)
% CircleCenter(p1, p2, p3) 根据三个空间点，计算出其圆心
%   p1,p2,p3:三个空间点
 % 圆的法向量
 pf= cross(p1-p2, p1-p3);

 if (pf == 0)
     error('三个点不能共线！！');
 end

 % 两条线段的重点，之后需要求中垂线
 p12 = (p1 + p2)/2;
 p23 = (p2 + p3)/2;

 % 求两条线的中垂线
 p12f = cross(pf, p1-p2);
 p23f = cross(pf, p2-p3);

 % 求在中垂线上投影的大小
 ds = ( (p12(2)-p23(2))*p12f(1) - (p12(1)-p23(1))*p12f(2) ) / ( p23f(2)*p12f(1) - p12f(2)*p23f(1) );

 % 得出距离
 p = p23 + p23f .* ds;
V=norm(p-p1);
end
