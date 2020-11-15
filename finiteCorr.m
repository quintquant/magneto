%%%%%%%%%%%%
% FUNCTION: finiteCorr
%           Evaluates the correlators in pair for a given temperature T. calls in pureCorr.
% INPUT:... delta   Positive Integer. Position i
%           deltap  Positive Integer. Position j
%           sigma_1 and sigma_2 pauli matrices. what type of correlator do you want? xx, xy etc
%           N       Positive Integer. size of Finite system.
%           states_array. matrix (2^N,2^N) are the eigenstates calculated from diagonalising
%           the Hamiltonian. Using function DiagHmat.
%           T               Positive number. Temperature as a percentage of J.
%           energies_array  vector 2^N.      Eigenvalues of the system.
%           partZ   Positive number. Partition Function
% OUTPUT:...finiteCorrelator. A number. the realspace correlation value for a given pair difined
%           by delta and deltap position at a given temperature for teh original set of
%           parameters. Gamma, Delta, field etc.
function finiteCorrelator=finiteCorr(delta,deltap,sigma_1,sigma_2,N,states_array,energies_vec,T,partZ)
  correlatorPair=corrPair(delta,deltap,sigma_1,sigma_2,N);
  finCorr=0;
	for ii=1:2**N
	   pureCorrPoint(ii,:)=(conj(states_array(:,ii)'))*(correlatorPair*states_array(:,ii));
     value=(pureCorrPoint(ii)*exp((-energies_vec(ii))/T))/partZ;
     finCorr=finCorr+value;
	endfor
  finiteCorrelator=finCorr;
endfunction
