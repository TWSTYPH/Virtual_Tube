function [p,V] = CircleCenter(p1, p2, p3)
% CircleCenter(p1, p2, p3) ���������ռ�㣬�������Բ��
%   p1,p2,p3:�����ռ��
 % Բ�ķ�����
 pf= cross(p1-p2, p1-p3);

 if (pf == 0)
     error('�����㲻�ܹ��ߣ���');
 end

 % �����߶ε��ص㣬֮����Ҫ���д���
 p12 = (p1 + p2)/2;
 p23 = (p2 + p3)/2;

 % �������ߵ��д���
 p12f = cross(pf, p1-p2);
 p23f = cross(pf, p2-p3);

 % �����д�����ͶӰ�Ĵ�С
 ds = ( (p12(2)-p23(2))*p12f(1) - (p12(1)-p23(1))*p12f(2) ) / ( p23f(2)*p12f(1) - p12f(2)*p23f(1) );

 % �ó�����
 p = p23 + p23f .* ds;
V=norm(p-p1);
end
