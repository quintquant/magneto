%%%%%%%%%%
% FUNCTION: theta: rotation angle per site for a square plaquette
% INPUT:    delta   site delta 1:4
% OUTPUT:   thetan  theta for delta
%
function thetan=theta(delta,N)
   thetan=((2*delta)-1)*(pi/N);
endfunction
