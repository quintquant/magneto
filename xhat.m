%%%%%%%%%%%
%
% FUNCTION xhat
%          unit vector componant
% INPUT    qx qy
%
% Output   qhat
%
function qhat=xhat(q1,q2)
  qhat=q1/(sqrt((q1^2)+(q2^2)));
endfunction
