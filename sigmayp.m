%%%%%%%%%%
% FUNCTION: sigmay: calculates y prime sigma y per site dependent on the rotation
% INPUT:    theta in itself dependent on site
% OUTPUT:   rotated operator
%%%%%%%%%%
%
function sigmay=sigmayp(theta)
  px=[0,1;1,0];
  py=[0,-i;i,0];
  Theta=(2*pi)-theta;
  sigmay=px*sin(Theta)+py*cos(Theta);
end
