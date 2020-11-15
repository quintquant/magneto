%%%%%%%%%%
% FUNCTION: pbHmat:
%          This function calls in function spinConstruct threee times for SxSx, SySy and SzSz.
%          It taske the spin interaction matrices and field components and evaluates them in
%          the Heisenberg Hamiltonian. This is for PERIODIC BOUNDARY CONDITIONS.
% INPUT:   N      Positive Integer. Size of finite Chain.
%          Gamma  Positive number 0<Gamma<1. Anisotropy for x and y
%          Delta  Positive number. Anisotropy for z. taken as zero for xy model.
%          h      Positive number. Effective field. i.e h=1 is the critical field.
% OUTPUT   The Hamiltonian matrix (2^N,2^N)
%
function Hmatrix=pbHmat(N,Gamma,Delta,h)
% combime for the Hamiltonian. INPUT: Gamma, Delta and field call in above function, require input N
%
   [SxSx,F_matrix]=PBspinConstruct([0,1;1,0],N);   % call in for x,y,z
   [SySy,F_matrix]=PBspinConstruct([0,i;-i,0],N);
   [SzSz,F_matrix]=PBspinConstruct([1,0;0,-1],N);

   Vx=SxSx*(1+Gamma);     % add anisotropy for x,y and z
   Vy=SySy*(1-Gamma);
   Vz=SzSz*Delta;

   Hmatrix=(1/4)*(Vx+Vy+Vz)-(1/2)*h*F_matrix;       % construct hamiltonian matrix with field.

end
%%%%%%%%%%
