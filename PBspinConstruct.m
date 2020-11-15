%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% FUNCTION: PBspinConstruction :
%           This function creates spin matrices that describe the interaction and field
%           componants in the Hamiltonian for PERIODIC BOUNDARY CONDITIONS
%
% INPUT:    sigma     Pauli Matrix (2x2). for x y z
%           N         Positive Interger. Size of chain. Has limiting factors. N=13 is max.
%
% OUTPUT:   Spin Matrix (2^N,2^N) for S(alpa)i*S(alpha)i+1
%           Field Matrix (2^n,2^n) transverse field component.
%
function [pbSpin_matrix,F_matrix]=PBspinConstruct(sigma,N)
  Spin_matrix=zeros((2^N),(2^N));
  for ii=1:N-1
    interactionMat=kron(eye(2^(ii-1),2^(ii-1)),(kron(sigma,eye(2^(N-ii),2^(N-ii)))))*kron(eye(2^(ii),2^(ii)),(kron(sigma,eye(2^(N-ii-1),2^(N-ii-1)))));
    Spin_matrix=Spin_matrix+interactionMat;
  endfor
  pb=kron(eye(2^(N-1),2^(N-1)),sigma)*kron(sigma,eye(2^(N-1),2^(N-1)));
  pbSpin_matrix=Spin_matrix+pb;
  % field component. NOTE: this assumes a transverse field in the Z direction
  F_matrix=zeros(2^N,2^N);
  for jj=1:N
    fieldElement=kron(eye(2^(jj-1)),(kron(([1,0;0,-1]),eye(2^(N-jj),2^(N-jj)))));
    F_matrix=F_matrix+fieldElement;
  endfor
end
