function d = mydistance(x,S)
% x  Compared position
% S  Defined to save current waypoints and obstacles for distance check, in form of [x1 x2 x3 ...xn]
% d  Minimum distance between x and (x1 x2 x3 ...xn) 

 sz = size(S);

 if  isempty(S)==1 % If S is empty, we set a distance larger than r
     d = r+1;
     
 else   % If S is not empty
    A = repmat(x,1,sz(2)) - S;
    
    for k=1:sz(2) % Distance in horizontal direction
       Norm_Store(k)=norm(A(1:2,k));
    end
    
    d = min(Norm_Store);
    
end