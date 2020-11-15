%%%%%%%%%%
% FUNCTION: DiagpbHmat:
%           This calls in Hmat so would be the only required function to call by a script to
%           generate eigenvalues and eigenvecors for a system for a given range of h. h can be
%           a single number or a vector. It does this through exact diagonilisation.
%           This is for PERIODIC BOUNDARY CONDITIONS.
% INPUT:    N      Positive Integer. Size of Finite chain
%           Gamma  Positive number. 0<Gamma<1. Anisotropy for x and y
%           Delta  Positive number. Anisotropy for z. taken as zero for xy model.
%           h_vec  Positive number or vector. Effective field. i.e h=1 is the critical field.
% OUTPUT    eVec   Matrix (2^N,2^N) of eigen vectors.
%           eVal   Vector 2^N of eigen values.
function [eVec,eVal]=DiagpbHmat(N,Gamma,Delta,h_vec)
	for ii=1:length(h_vec) % h_vec can be a single field value of a vector range of them.
		h=h_vec(ii); %(not 100% on this one for h as a vector) check this
		[e_vector,e_value]=eig(pbHmat(N,Gamma,Delta,h));
		eVec(:,:,ii)=e_vector;
		eVal(:,ii)=diag(e_value);
	endfor
end
%%%%%%%%%%
