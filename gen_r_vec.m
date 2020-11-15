% Position vectors of atoms in molecule with N atoms,
% expressed in units of the distance a between n.n. atoms.
%
function r_vec=gen_r_vec(N)
    % Distance between n.n. atoms in units of the molecule's radius:
    a=2*sin(pi/N);
    % Angle increment from one atom to the next:
    dphi=2*pi/N;
    % Angles at which all N atoms are found:
    phi=(pi/2-0.5*dphi:-dphi:-3*pi/2+0.5*dphi)';
    % Coordinates of all atoms (in units of the radius):
    x=cos(phi);
    y=sin(phi);
    r_vec=[x,y];
    % Divide by a to obtain final result in the desired units:
    r_vec=r_vec/a;
endfunction
