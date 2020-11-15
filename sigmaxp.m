%%%%%%%%%%
% FUNCTION: sigmax: calculates x prime sigma x per site dependent on the rotation
% INPUT:    theta in itself dependent on site
% OUTPUT:   rotated operator
%%%%%%%%%%
%
function sigmax=sigmaxp(theta)
  px=[0,1;1,0];
  py=[0,-i;i,0];
  Theta=(2*pi)-theta;
  sigmax=px*cos(Theta)-py*sin(Theta);
end
