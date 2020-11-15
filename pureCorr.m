%%%%%%%%%%%
% FUNCTION: pureCorr
%           Evaluates the realspace correlation value for a given pair of sites i and j.
%           assumes the system is in a pure state. to then be fed into finiteCorr for finite
%           temperatture results. Groundstate given here for T=0 when using states_array(:1)
%           only. Calls in operator function.
% INPUT:... delta   Positive Integer. Position i
%           deltap  Positive Integer. Position j
%           sigma_1 and sigma_2 pauli matrices. what type of correlator do you want? xx, xy etc
%           N       Positive Integer. size of Finite system.
%           states_array. matrix (2^N,2^N) are the eigenstates calculated from diagonalising
%           the Hamiltonian. Using function DiagHmat.
%           NOTE: must take states_array as a matrix, can't take one vector at a time. this
%           feature is integrated into finiteCorr function so as to not require this one.
% OUTPUT:...pureCorrPoint   vector (2^N) correlator value per state for a given pair of sites.
%
function pureCorrPoint=pureCorr(delta,deltap,sigma_1,sigma_2,N,states_array)
   correlatorPair=corrPair(delta,deltap,sigma_1,sigma_2,N);   % compute operator pair
                                                              % compute expectation value for each state
      for ii=1:2**N
               pureCorrPoint(ii,:)=(conj(states_array(:,ii)'))*(correlatorPair*states_array(:,ii));
    endfor
end
